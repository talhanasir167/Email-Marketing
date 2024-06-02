# frozen_string_literal: true

class ScheduleEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mailers'

  def perform(params)
    params = params.with_indifferent_access
    lead = Lead.find(params[:lead_id])

    return if ProcessedLead.joins(:compaign, :lead).where(compaign: { service_id: params[:service_id] },
                                                          lead: { email: lead.email }).exists?

    send_mail_params = send_mail_params(lead, params)
    msg = UserMailer.send_email(send_mail_params).deliver_now
    ProcessedLead.create(message_id: msg.message_id, lead_id: params[:lead_id], compaign_id: params[:compaign_id],
                         email_subject: send_mail_params['subject'])
  end

  private

  def send_mail_params(lead, params)
    compaign = Compaign.find(params[:compaign_id])
    {
      'business_id' => params[:business_id],
      'email' => lead.email,
      'subject' => compaign.email_subject.gsub('{NAME}', lead.name),
      'sender_email' => params[:sender_email],
      'email_body' => compaign.email_body.gsub('{NAME}', lead.name)
    }
  end
end
