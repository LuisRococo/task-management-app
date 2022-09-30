class PagesController < ApplicationController
  skip_before_action :authorize!
  skip_before_action :authenticate_user!

  def home
  end

  def plans
    @plans = Plan.all
  end
end
