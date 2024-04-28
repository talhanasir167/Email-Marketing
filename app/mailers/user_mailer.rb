class UserMailer < ApplicationMailer
  helper CompaignsHelper

  def send_email(params)
    @body = params[:body]
    @business = params[:business]

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email],
         delivery_method_options: delivery_options)
  end

  def send_followup_email(params)
    @body = params[:body]
    @business = params[:business]

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email],
         references: params[:message_id], delivery_method_options: delivery_options)
  end

  private

  def delivery_options
    { user_name: @business.email, password: @business.encrypted_password }
  end
end
