module AuthHelper
  def user_logged
    !!current_user
  end
end
