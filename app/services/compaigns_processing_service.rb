class CompaignsProcessingService
  require 'csv'

  TIME_SPAN = 60

  def initialize(params)
    @compaign = params[:compaign]
    @csv = params[:csv_file]
    @service = @compaign.service
    @business = @compaign.business
    @lead_params = params[:lead_params]
  end

  def call!
    process_csv
  end

  def process_csv
    file_path = File.open(@csv)

    CSV.foreach(file_path, headers: true) do |row|
      row = parocessed_row(row)

      next if ProcessedLead.joins(:compaign, :lead).where(compaign: { service_id: @service.id },
                                                          lead: { email: row[:email] }).exists?

      lead = find_or_create_lead(row[:name], row[:email])
      params = mail_params(lead.id)
      ScheduleEmailWorker.perform_in((@compaign.scheduled_at + rand(TIME_SPAN).minutes).to_datetime, params)
    end
  end

  private

  def parocessed_row(row)
    {
      name: row['Name']&.strip&.titleize || '',
      email: row['Email'].strip.downcase
    }
  end

  def find_or_create_lead(name, email)
    lead = Lead.find_or_initialize_by(email:)
    lead.country_id = @lead_params['country_id']
    lead.platform_id = @lead_params['platform_id']
    lead.title_id = @lead_params['title_id']
    lead.name = name if lead.name.blank?
    lead.save

    lead
  end

  def sender_email
    business_name = @business.name.titlecase
    "#{business_name} <#{@compaign.business_email.email}>"
  end

  def mail_params(lead_id)
    {
      'sender_email' => sender_email,
      'business_id' => @business.id,
      'lead_id' => lead_id,
      'service_id' => @service.id,
      'compaign_id' => @compaign.id
    }
  end
end
