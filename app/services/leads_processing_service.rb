class LeadsProcessingService
  require 'csv'

  def initialize(params)
    @lead = params[:lead_id]
    @csv = params[:csv_file]
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
    msg = UserMailer.send_email(email, subject).deliver_now
    GeneratedEmail.create(email:, subject:, message_id: msg.message_id, user_id: user.id)
  end

  def find_or_create_user(name, email)
    user = @lead.users.find_or_initialize_by(email:)
    user.name = name
    user.save

    user
  end
end
