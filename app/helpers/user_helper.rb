module UserHelper
  def user_has_free_trial?(user)
    user.has_free_trial?
  end
end
