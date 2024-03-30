class UserMailer < ApplicationMailer
  default from: 'Your Tech Buddies <team@yourtechbuddies.com>'
  def send_email(email, subject)
    @email = email
    mail(to: email, subject:)
  end

  def send_email_reply(email, subject, message_id)
    @body = 'Hy this is just testing reply email'
    mail(to: email, subject: subject, body: @body, references: message_id,
         content_type: 'text/html')
  end
end
