class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :access_to_plan_page, only: [:plans]

  def home
  end

  def plans
    @plans = Plan.all
  end

  private

  def access_to_plan_page
    if current_user && !current_user.access_to_plan_show_page
      flash[:alert] = 'You cannot access this page'
      redirect_to root_path
    end
  end
end
