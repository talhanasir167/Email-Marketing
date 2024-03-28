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

      send_email(email, subject)
      create_user(name, email)
    end
  end

  private

  def parocessed_row(row)
    {
      name: row['Name']&.strip || '',
      email: row['Email'].strip,
      subject: row['Subject'].strip
    }
  end

  def send_email(email, subject)
    UserMailer.send_email(email, subject).deliver_now
  end

  def create_user(name, email)
    user = @lead.users.find_or_initialize_by(email:)
    user.name = name
    user.save
  end
end
