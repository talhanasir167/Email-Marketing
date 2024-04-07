class FollowupService
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
      UserMailer.send_followup_email(params).deliver_now
    end

    @followup.update(sent: true)
  end

  private

  def followup_params(generated_email)
    {
      email: generated_email.email,
      subject: generated_email.subject,
      name: generated_email.contact.name,
      sender_email:,
      message_id: generated_email.message_id,
      body: followup_body(generated_email.contact.name)
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
