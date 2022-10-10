# frozen_string_literal: true

module AuthHelper
  def user_logged?
    !!current_user
  end

  def user_can_access_team_resources
    user_logged? && user_manager?
  end

  def user_admin?
    user_logged? && current_user.authorization_tier == 'admin'
  end

  def user_manager?
    user_logged? && current_user.authorization_tier == 'manager'
  end

  def regular_user?
    user_logged? && current_user.authorization_tier == 'user'
  end

  def access_to_plan_page
    return true unless user_logged?
    current_user.access_to_plan_show_page
  end

  def same_user?(target_user)
    current_user == target_user
  end
end
