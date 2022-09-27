class PlansController < ApplicationController
  before_action :set_plan, only: [:edit, :update, :destroy, :show]

  def index
    @plans = Plan.all
  end

  def show
  end

  def edit
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:notice] = 'Plan was create successfully'
      redirect_to plans_path
    else
      flash.now[:alert] = 'There was an error'
      render 'new'
    end
  end

  def update
    if @plan.update(plan_params)
      flash[:notice] = 'The plan was successfully updated'
      redirect_to plans_path
    else
      flash.now[:error] = 'There was an error'
      render 'update'
    end
  end

  def destroy
    if @plan.destroy
      flash[:notice] = 'The plan was successfully deleted'
      redirect_to plans_path
    else
      flash[:alert] = 'There was an error'
      redirect_to plans_path
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
