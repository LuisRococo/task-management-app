class TrialFinisherJob < ApplicationJob
  queue_as :default

  def end_expired_trials
    User.where(trial_block: false, authorization_tier: 'manager', plan_id: nil).each do |manager|
      if manager.has_trial_expired?
        manager.trial_block = true
      end
    end
  end

  def perform(*args)
    end_expired_trials
    self.class.set(wait_until: Date.tomorrow.noon).perform_later
  end
end
