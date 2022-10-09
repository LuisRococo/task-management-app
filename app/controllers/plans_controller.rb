# frozen_string_literal: true

class PlansController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    admin: :all
  )
  before_action :set_plan, only: %i[edit update destroy show]

  def index
    @plans = Plan.all
    respond_to do |format|
      format.html
      format.json { render json: @plans }
    end
  end

  def show; end

  def edit; end

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
    if Plan.where(plan_id: @plan.id).joins(:users).count != 0
      flash[:alert] = 'You can not delete a plan while it has users in it.'
      redirect_to plans_path
      return
    end

    if @plan.destroy
      flash[:notice] = 'The plan was successfully deleted'
    else
      flash[:alert] = 'There was an error'
    end
    redirect_to plans_path
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:title, :member_quantity, :price, :time_months)
  end
end
