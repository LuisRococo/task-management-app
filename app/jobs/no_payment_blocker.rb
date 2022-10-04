class NoPaymentBlocker < ApplicationJob
  queue_as :default

  def self.init
    NoPaymentBlocker.set(wait_until: Date.tomorrow.noon).perform_later
  end

  def block_users
    User.where(authorization_tier: 'manager', pay_block: false).where.not(plan_id: nil).each do |manager|
      if manager.has_payment_expired?
        manager.trial_block = true
      end
    end
  end

  def perform(*args)
    block_users
    NoPaymentBlocker.init
  end
end
