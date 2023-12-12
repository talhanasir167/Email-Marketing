class UserMailer < ApplicationMailer
  def send_email(email, subject)
    @email = email
    

    mail(to: @email, subject: subject)
  end
end
