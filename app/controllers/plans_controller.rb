class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :edit, :update]
  before_action :set_plan, only: [:edit, :update]

  def index
    @plans = Plan.all
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:notice] = 'The plan was successfully updated'
      redirect_to plans_path
    else
      flash[:error] = 'There was an error'
      render 'update'
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:title, :member_quantity, :price, :time_months)
  end
end
