class TaskUsersController < ApplicationController
  before_action :set_user_to_add, only: [:create]

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
end
