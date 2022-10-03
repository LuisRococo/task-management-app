module AuthHelper
  def user_logged?
    !!current_user
  end

  def user_can_access_team_resources
    user_logged? && current_user.authorization_tier == 'manager'
  end

  def user_admin?
    user_logged? && current_user.authorization_tier == 'admin'
  end
end
