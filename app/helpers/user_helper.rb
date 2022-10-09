# frozen_string_literal: true

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

  def white_listed?(user)
    user.white_listed?
  end

  def random_message
    messages = [
      'When you have a dream, you\'ve got to grab it and never let go.',
      'Nothing is impossible. The word itself says \'I\'m possible!\'',
      'There is nothing impossible to they who will try.',
      'The bad news is time flies. The good news is you\'re the pilot.',
      'Life has got all those twists and turns. You\'ve got to hold on tight and off you go.',
      'Keep your face always toward the sunshine, and shadows will fall behind you.'
    ]
    messages[rand(0...messages.count)]
  end
end
