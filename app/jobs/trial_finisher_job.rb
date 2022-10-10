# frozen_string_literal: true

class TrialFinisherJob < ApplicationJob
  queue_as :default

  def self.init
    TrialFinisherJob.set(wait_until: Date.tomorrow.noon).perform_later
  end

  def end_expired_trials
    User.where(trial_block: false, authorization_tier: 'manager', plan_id: nil).each do |manager|
      manager.trial_block = true if manager.calculate_has_trial_expired?
    end
  end

  def perform(*_args)
    end_expired_trials
    TrialFinisherJob.init
  end
end
