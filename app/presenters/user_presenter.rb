class UserPresenter
  def initialize(user)
    @user = user
  end

  def show_page_header
    { title: @user.full_name,
      text: "User profile",
      config: false }
  end

  def auth_tier
    @user.authorization_tier.capitalize
  end

  def should_show_manager_name?
    @user.authorization_tier == 'user'
  end

end
