class ApplicationController < ActionController::Base
  include AuthorizedPersona::Authorization
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :board_index_path, :access_to_user_crud?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :password, :current_password)}
  end

  private

  def current_user_manager
    if current_user.authorization_tier == 'user'
      current_user.manager
    else
      current_user
    end
  end

  def board_index_path(user)
    board_author = user.authorization_tier == 'user' ? user.manager : user
    user_boards_path(board_author)
  end

  def access_to_user_crud?(target_user)
    return true if target_user == current_user
    return true if current_user.authorization_tier == 'admin'
    current_user.is_manager_or_manager_team?(target_user)
  end
end
