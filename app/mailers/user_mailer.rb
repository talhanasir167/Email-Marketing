class UserMailer < ApplicationMailer
  helper LeadsHelper

  def send_email(email, subject, sender_email)
    @email = email
    mail(to: email, subject:, from: sender_email)
  end

  def send_followup_email(params)
    @followup_count = params[:followup_count]
    @name = params[:name]

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email], references: params[:message_id], content_type: 'text/html')
  end
end
