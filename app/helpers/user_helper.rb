module UserHelper
  def user_has_free_trial?(user)
    user.has_free_trial?
  end

  def show_user_block_btn?(target_user)
    is_current_user_admin = current_user.authorization_tier == 'admin'
    target_user.authorization_tier == 'manager' && is_current_user_admin
  end

  def show_end_trial_btn?(target_user)
    target_user.has_free_trial? && target_user.authorization_tier == 'manager'
  end
end
