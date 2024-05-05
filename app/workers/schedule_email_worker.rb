# frozen_string_literal: true

class ScheduleEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mailers'

  def perform(params)
    params = params.transform_keys(&:to_sym)
    return if GeneratedEmail.where(service_id: params[:service_id], lead_id: params[:lead_id]).exists?

    send_mail_params = params.except(:lead_id, :service_id)
    msg = UserMailer.send_email(send_mail_params).deliver_now
    GeneratedEmail.create(email: params[:email], subject: params[:subject], message_id: msg.message_id,
                          lead_id: params[:lead_id], service_id: params[:service_id])
  end
end
