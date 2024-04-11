class UserMailer < ApplicationMailer
  helper LeadsHelper

  def send_email(params)
    @body = params[:body]

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email],
         delivery_method_options: delivery_options(params))
  end

  def send_followup_email(params)
    @body = params[:body]

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email],
         references: params[:message_id], delivery_method_options: delivery_options(params))
  end

  private

  def delivery_options(params)
    { user_name: params[:configured_email], password: params[:encrypted_password] }
  end
end
