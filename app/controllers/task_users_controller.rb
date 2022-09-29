class TaskUsersController < ApplicationController
  before_action :set_user_to_add, only: [:create]
  before_action :valid_user, only: [:create]

  def create
    task_user = TaskUser.create(user: @user_to_add, task_id: params[:task_id])
    if task_user.save
      flash[:notice] = 'User add to task'
    else
      flash[:alert] = 'Error on adding user to task'
    end
    redirect_to task_path(params[:task_id])
  end

  private

  def set_user_to_add
    @user_to_add = User.find_by(email: params[:email])
  end

  def valid_user
    if @user_to_add.nil?
      flash[:alert] = 'The email does not belongs to any user'
      redirect_to task_path(params[:task_id])
    elsif @user_to_add.user_on_task?(params[:task_id])
      flash[:alert] = 'The user already is assigned on the task'
      redirect_to task_path(params[:task_id])
    end
  end
end
