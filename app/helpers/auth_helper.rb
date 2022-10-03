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
end
