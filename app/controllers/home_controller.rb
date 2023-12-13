class HomeController < ApplicationController
  def index; end

  def create_emails
    if params_valid?
      CsvMailer::CsvEmailService.new.perform(service_params)
      flash.now[:notice] = 'Your Request is processed'
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('form-container', partial: 'data_form'),
            turbo_stream.prepend('flash-toast', partial: 'toast_notification')
          ]
        end
      end
    else
      flash.now[:error] = 'There is an error processing your request!'
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend('flash-toast', partial: 'toast_notification')
        end
      end
    end
  end

  private

  def service_params
    params.permit(:company_name, :business_email, :csv_file)
  end

  def params_valid?
    service_params.present? && service_params[:company_name].present? &&  service_params[:business_email].present? &&  service_params[:csv_file].present?
  end
end
