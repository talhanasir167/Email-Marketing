class FollowupService
  def initialize(params)
    @lead = params[:lead]
    @followup_count = params[:followup_count]
  end

  def call!
    process_followups
  end

  def process_followups
    GeneratedEmail.followup_emails(@lead.business, @lead.contacts).each do |generated_email|
      params = followup_params(generated_email)
      UserMailer.send_followup_email(params).deliver_now
    end

    @lead.update(followup_count: @lead.followup_count + 1)
  end

  private

  def followup_params(generated_email)
    {
      email: generated_email.email,
      subject: generated_email.subject,
      name: generated_email.contact.name,
      sender_email:,
      followup_count: @followup_count,
      message_id: generated_email.message_id
    }
  end

  def sender_email
    business_name = @lead.business.name.titlecase
    "#{business_name} <#{@lead.business_email.email}>"
  end
end
