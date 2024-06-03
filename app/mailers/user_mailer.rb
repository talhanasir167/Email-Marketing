class UserMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper
  helper CompaignsHelper

  def send_email(params)
    params = params.with_indifferent_access

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email],
         delivery_method_options: delivery_options(params)) do |format|
      format.html { render html: simple_format(params[:email_body].html_safe) }
    end
  end

  def send_followup_email(params)
    params = params.with_indifferent_access

    mail(to: params[:email], subject: params[:subject], from: params[:sender_email], references: params[:message_id],
         delivery_method_options: delivery_options(params)) do |format|
      format.html { render html: simple_format(params[:followup_body].html_safe) }
    end
  end

  private

  def delivery_options(params)
    business = Business.find(params[:business_id])
    { user_name: business.email, password: business.encrypted_password }
  end
end
