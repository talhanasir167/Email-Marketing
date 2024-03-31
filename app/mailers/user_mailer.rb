class UserMailer < ApplicationMailer
  helper LeadsHelper

  default from: 'Your Tech Buddies <team@yourtechbuddies.com>'
  def send_email(email, subject)
    @email = email
    mail(to: email, subject:)
  end

  def send_followup_email(params)
    @followup_count = params[:followup_count]
    @name = params[:name]

    mail(to: params[:email], subject: params[:subject], references: params[:message_id], content_type: 'text/html')
  end
end
