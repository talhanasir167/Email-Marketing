class UserMailer < ApplicationMailer
  helper LeadsHelper

  def send_email(email, subject, sender_email)
    @email = email
    mail(to: email, subject:, from: sender_email)
  end

  def send_followup_email(params)
    @body = params[:body]
    mail(to: params[:email], subject: params[:subject], body: params[:body], from: params[:sender_email],
         references: params[:message_id], content_type: 'text/html')
  end
end
