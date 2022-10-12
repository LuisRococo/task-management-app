# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthorizedPersona::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :block_no_paid_plans_users, unless: :devise_controller?
  before_action :block_trial_expirated_users, unless: :devise_controller?
  before_action :block_entry_to_blocked_users, unless: :devise_controller?

  helper_method :board_index_path, :access_to_user_crud?

  protected

  # why is this in the application.rb 
  # shouldn't this go within a more devise
  # specific controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :password, :current_password)
    end
  end

  private

  def block_access_to_admin
    if current_user && current_user.authorization_tier == 'admin'
      flash[:alert] = 'Admins do not have access to these resources'
      redirect_back(fallback_location: root_path)
    end
  end

  def block_no_paid_plans_users
    if current_user&.has_payment_block?
      redirect_to '/payment-block'
      flash[:alert] = 'Your plan has expired'
    end
  end

  def block_trial_expirated_users
    if current_user&.has_trial_block?
      redirect_to '/trial-block'
      flash[:alert] = 'Your trial has expired'
    end
  end

  def block_entry_to_blocked_users
    if current_user&.has_user_block?
      redirect_to '/user-block'
      flash[:alert] = 'You have been blocked'
    end
  end

  # this should go at the model, not at the controller
  def current_user_manager
    if current_user.authorization_tier == 'user'
      current_user.manager
    else
      current_user
    end
  end

  # could do something a little bit more ruby
  def board_index_path(user)
    board_author = user.authorization_tier == 'user' ? user.manager : user
    user_boards_path(board_author)
    # user_boards_path(board_author) if board_author.is_user?
    # or
    # board_author.is_user? ? user_boards_path(board_author) : another_return
  end

  # method that does too little
  def access_to_user_crud?(target_user)
    current_user.has_access_to_user_crud?(target_user)
  end
end
