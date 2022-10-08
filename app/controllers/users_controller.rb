class UsersController < ApplicationController
  authorize_persona class_name: "User"
  grant(
    user: :all,
    manager: :all,
    admin: :all,
  )

  skip_before_action :block_trial_expirated_users, only: [:set_plan]
  before_action :set_user, except: [:set_plan]
  before_action :access_to_crud, only: [:end_trial, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'The user was updated'
    else
      flash[:alert] = 'There was an error'
    end
    redirect_back(fallback_location: root_path)
  end

  def end_trial
    @user.end_trial_period
    flash[:notice] = 'Trial period has finished'
    redirect_back(fallback_location: root_path)
  end

  def set_plan
    unless current_user.can_plan_be_set?
      flash[:alert] = 'Can not set plan to this user'
      redirect_back(fallback_location: root_path)
      return
    end

    plan_to_add = Plan.find(params[:plan_id])
    current_user.set_plan(plan_to_add)
    
    flash[:notice] = "You now have the '#{plan_to_add.title}' plan"
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def access_to_crud
    unless access_to_user_crud?(@user)
      flash[:alert] = 'You do not have access to modify this user'
      redirect_back(fallback_location: root_path)
    end
  end
end
