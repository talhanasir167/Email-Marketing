class FollowupService
  TIME_SPAN = 60

  def initialize(followup)
    @followup = followup
    @compaign = @followup.compaign
  end

  def call!
    process_followups
  end

  def process_followups
    @compaign.processed_leads.where(active: true).includes(:lead).each do |processed_lead|
      params = followup_params(processed_lead)

      FollowupEmailWorker.perform_in((DateTime.now + rand(TIME_SPAN).minutes).to_datetime, params)
    end

    @followup.update(sent: true)
  end

  private

  def followup_params(processed_lead)
    {
      'followup_id' => @followup.id,
      'email' => processed_lead.lead.email,
      'subject' => processed_lead.email_subject,
      'sender_email' => sender_email,
      'message_id' => processed_lead.message_id,
      'followup_body' => followup_body(processed_lead.lead.name),
      'business_id' => @compaign.business.id
    }
  end

  def sender_email
    business_name = @compaign.business.name.titlecase
    "#{business_name} <#{@compaign.business_email.email}>"
  end

  def followup_body(name)
    @followup.content.gsub('{NAME}', name)
  end
end
