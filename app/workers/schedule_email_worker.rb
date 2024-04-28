# frozen_string_literal: true

class ScheduleEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mailers'

  def perform(params)
    params = params.transform_keys(&:to_sym)
    business = Business.find(params[:business_id])
    lead = Lead.find(params[:lead_id])
    return if GeneratedEmail.where(business:, lead:).exists?

    send_mail_params = mail_params(params, business)
    msg = UserMailer.send_email(send_mail_params).deliver_now
    GeneratedEmail.create(email: params[:email], subject: params[:subject], message_id: msg.message_id, lead:,
                          business:)
  end

  private

  def mail_params(params, business)
    {
      email: params[:email],
      subject: params[:subject],
      sender_email: params[:sender_email],
      business:,
      body: params[:body]
    }
  end
end
