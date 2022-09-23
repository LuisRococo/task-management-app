class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @plans = Plan.all
  end
end
