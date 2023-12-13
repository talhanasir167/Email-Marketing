class UserMailer < ApplicationMailer
  default from: 'Your Tech Buddies <team@yourtechbuddies.com>'
  def send_email(email, subject)
    @email = email
    mail(to: @email, subject: subject)
  end
end
