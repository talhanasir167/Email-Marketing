class FollowupService
  TIME_SPAN = 60

  def initialize(followup)
    @followup = followup
    @lead = @followup.lead
  end

  def call!
    process_followups
  end

  def process_followups
    GeneratedEmail.followup_emails(@lead.business, @lead.contacts).each do |generated_email|
      params = followup_params(generated_email)

      FollowupEmailWorker.perform_in((DateTime.now + rand(TIME_SPAN).minutes).to_datetime, params)
    end

    @followup.update(sent: true)
  end

  private

  def followup_params(generated_email)
    {
      'email' => generated_email.email,
      'subject' => generated_email.subject,
      'sender_email' => sender_email,
      'message_id' => generated_email.message_id,
      'body' => followup_body(generated_email.contact.name),
      'business' => @lead.business.id
    }
  end

  def sender_email
    business_name = @lead.business.name.titlecase
    "#{business_name} <#{@lead.business_email.email}>"
  end

  def followup_body(name)
    @followup.content.gsub('{NAME}', name)
  end
end
