class ApplicationController < ActionController::Base
  include AuthorizedPersona::Authorization
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  authorize_persona class_name: "User"

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :password, :current_password)}
  end
end
