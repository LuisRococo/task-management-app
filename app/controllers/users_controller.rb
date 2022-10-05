class UsersController < ApplicationController
  authorize_persona class_name: "User"
  grant(
    user: :all,
    manager: :all,
    admin: :all,
  )

  before_action :set_user, only: [:show, :end_trial]
  before_action :access_to_crud, only: [:end_trial]

  def show
  end

  def end_trial
    @user.end_trial_period
    flash[:notice] = 'Trial period has finished'
    redirect_back(fallback_location: root_path)
  end

  private

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
