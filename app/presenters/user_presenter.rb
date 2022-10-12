# frozen_string_literal: true

# another great example of a presenter.
class UserPresenter
  def initialize(user)
    @user = user
  end

  def show_page_header
    { title: @user.full_name,
      text: 'User profile',
      config: false }
  end

  def auth_tier
    @user.authorization_tier.capitalize
  end

  def should_show_manager_name?
    @user.authorization_tier == 'user'
  end

  def block_btn_text
    @user.has_user_block? ? 'Unblock user' : 'Block user'
  end
end
