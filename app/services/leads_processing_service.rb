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
      email = row[:email]
      name = row[:name]
      subject = row[:subject]

      user = find_or_create_user(name, email)
      create_and_send_email(email, subject, user)
    end

    @lead.update(count: CSV.foreach(file_path, headers: true).count)
  end

  private

  def parocessed_row(row)
    {
      name: row['Name']&.strip || '',
      email: row['Email'].strip,
      subject: row['Subject'].strip
    }
  end

  def create_and_send_email(email, subject, user)
    msg = UserMailer.send_email(email, subject).deliver_now
    GeneratedEmail.create(email:, subject:, message_id: msg.message_id, user_id: user.id) if user.generated_email.blank?
  end

  def find_or_create_user(name, email)
    user = @lead.users.find_or_initialize_by(email:)
    user.name = name
    user.save

    user
  end
end
