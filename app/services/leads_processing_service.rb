class LeadsProcessingService
  require 'csv'

  def initialize(params)
    @lead = params[:lead]
    @csv = params[:csv_file]
    @business = @lead.business
  end

  def call!
    process_csv
  end

  def process_csv
    file_path = File.open(@csv)

    CSV.foreach(file_path, headers: true) do |row|
      row = parocessed_row(row)
      next if @lead.business.leads.joins(:contacts).where(contacts: { email: row[:email] }).present?

      contact = find_or_create_contact(row[:name], row[:email])
      create_and_send_email(row, contact)
    end

    @lead.update(contacts_count: @lead.contacts.count)
  end

  private

  def parocessed_row(row)
    {
      name: row['Name']&.strip&.titleize || '',
      email: row['Email'].strip.downcase,
      subject: row['Subject'].strip,
      body: row['Body']
    }
  end

  def create_and_send_email(row, contact)
    return if GeneratedEmail.where(business: @business, contact:).exists?

    params = mail_params(row, sender_email)
    msg = UserMailer.send_email(params).deliver_now
    GeneratedEmail.create(email: row[:email], subject: row[:subject], message_id: msg.message_id, contact:, business: @business)
  end

  def find_or_create_contact(name, email)
    contact = @lead.contacts.find_or_initialize_by(email:)
    contact.name = name if contact.name.blank?
    contact.save

    contact
  end

  def sender_email
    business_name = @business.name.titlecase
    "#{business_name} <#{@lead.business_email.email}>"
  end

  def mail_params(row, sender_email)
    {
      email: row[:email],
      subject: row[:subject],
      sender_email:,
      business: @business,
      body: row[:body]
    }
  end
end
