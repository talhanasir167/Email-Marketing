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
      next if @lead.business.leads.joins(:users).where(users: { email: row[:email] }).present?

      user = find_or_create_user(row[:name], row[:email])
      create_and_send_email(row[:email], row[:subject], user)
    end

    @lead.update(count: @lead.users.count)
  end

  private

  def parocessed_row(row)
    {
      name: row['Name']&.strip&.titleize || '',
      email: row['Email'].strip.downcase,
      subject: row['Subject'].strip
    }
  end

  def create_and_send_email(email, subject, user)
    return if GeneratedEmail.where(business: @business, user:).exists?

    msg = UserMailer.send_email(email, subject).deliver_now
    GeneratedEmail.create(email:, subject:, message_id: msg.message_id, user:, business: @business)
  end

  def find_or_create_user(name, email)
    user = @lead.users.find_or_initialize_by(email:)
    user.name = name if user.name.blank?
    user.save

    user
  end
end
