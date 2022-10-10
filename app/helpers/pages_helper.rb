# frozen_string_literal: true

module PagesHelper
  def app_features
    features = [{ title: 'Feature',
                  description: 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti',
                  img: 'idea-black.jpg' }]
    features *= 4
  end

  def payment_block_card_options
    {
      title: 'Your application has been blocked',
      subtitle: ' Application block ',
      msj: 'You are required to pay to keep using the application. If you are not the team manager you should contact him.',
      url: new_payment_path
    }
  end

  def trial_block_card_options
    {
      title: 'Your application has been blocked',
      subtitle: 'Your trial is over',
      msj: 'You are required select a plan and pay to keep using the application. If you are not the team manager you should contact him.',
      url: '/our-plans'
    }
  end

  def user_block_card_options
    {
      title: 'Your boards have been blocked',
      subtitle: 'User block',
      msj: 'Your boards have been blocked by an admin. Contact us if you think it is a misunderstanding.',
      url: nil
    }
  end
end
