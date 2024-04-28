class CompaignsProcessingService
  require 'csv'

  TIME_SPAN = 60

  def initialize(params)
    @compaign = params[:compaign]
    @csv = params[:csv_file]
    @business = @compaign.business
    @service = @compaign.service
  end

  def call!
    process_csv
  end

  def process_csv
    file_path = File.open(@csv)

    CSV.foreach(file_path, headers: true) do |row|
      row = parocessed_row(row)
      next if @business.compaigns.joins(:contacts).where(service: @service, contacts: { email: row[:email] }).exists?

      contact = find_or_create_contact(row[:name], row[:email])
      params = mail_params(row, contact.id, @business.id)

      ScheduleEmailWorker.perform_in((@compaign.scheduled_at + rand(TIME_SPAN).minutes).to_datetime, params)
    end

    @compaign.update(contacts_count: @compaign.contacts.count)
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

  def find_or_create_contact(name, email)
    contact = @compaign.contacts.find_or_initialize_by(email:)
    contact.name = name if contact.name.blank?
    contact.save

    contact
  end

  def sender_email
    business_name = @business.name.titlecase
    "#{business_name} <#{@compaign.business_email.email}>"
  end

  def mail_params(row, contact_id, business_id)
    {
      'email' => row[:email],
      'subject' => row[:subject],
      'body' => row[:body],
      'sender_email' => sender_email,
      'business_id' => business_id,
      'contact_id' => contact_id
    }
  end
end
