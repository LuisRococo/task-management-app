# frozen_string_literal: true

module PaymentHelper
  def payment_new_header_page
    { title: 'Plan payment',
      text: 'Pay you plan and discover the potential of your team.',
      config: false }
  end

  def plan_cost
    current_user.plan.price.format
  end

  def plan_name
    current_user.plan.title.capitalize
  end
end
