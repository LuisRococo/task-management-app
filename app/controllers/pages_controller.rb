# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :block_no_paid_plans_users, only: [:payment_block]
  skip_before_action :block_trial_expirated_users, only: %i[trial_block plans]
  skip_before_action :block_entry_to_blocked_users, only: [:user_block]
  before_action :access_to_trial_block, only: [:trial_block]
  before_action :access_to_plan_page, only: [:plans]
  before_action :access_to_payment_block, only: [:payment_block]
  before_action :access_to_user_block, only: [:user_block]

  def home; end

  def plans
    @plans = Plan.all
  end

  def payment_block; end

  def trial_block; end

  def user_block; end

  private

  def access_to_plan_page
    if current_user && !current_user.access_to_plan_show_page
      flash[:alert] = 'Only managers can access this page'
      redirect_back(fallback_location: root_path)
    end
  end

  def access_to_payment_block
    redirect_back(fallback_location: root_path) unless current_user.has_payment_block?
  end

  def access_to_trial_block
    redirect_back(fallback_location: root_path) unless current_user.has_trial_block?
  end

  def access_to_user_block
    redirect_back(fallback_location: root_path) unless current_user.has_user_block?
  end
end
