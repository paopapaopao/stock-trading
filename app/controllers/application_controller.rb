class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role_id, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:role_id, :email, :password, :current_password) }
  end

  before_action :authenticate_user!
end
