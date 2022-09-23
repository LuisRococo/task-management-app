class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :edit]
  before_action :set_plan, only: [:edit]

  def index
    @plans = Plan.all
  end

  def edit
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
