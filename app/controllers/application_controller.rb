class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin_user!
    raise SecurityError unless current_user.admin?
  end

  rescue_from SecurityError do
    flash[:alert] = 'You are not authorized for this action'
    redirect_to root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name password])
  end
end
