class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :plans]

  def home
  end

  def plans
    @plans = Plan.all
  end
end
