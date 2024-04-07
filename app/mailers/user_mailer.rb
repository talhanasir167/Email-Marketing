class UserMailer < ApplicationMailer
  helper LeadsHelper

  def send_email(email, subject, sender_email, business)
    @email = email

    delivery_options = { user_name: business.email, password: business.encrypted_password }

    mail(to: email, subject:, from: sender_email, delivery_method_options: delivery_options)
  end

  def send_followup_email(params)
    @body = params[:body]

    delivery_options = { user_name: params[:configured_email], password: params[:encrypted_password] }

    mail(to: params[:email], subject: params[:subject], body: params[:body], from: params[:sender_email],
         references: params[:message_id], content_type: 'text/html', delivery_method_options: delivery_options)
  end
end
