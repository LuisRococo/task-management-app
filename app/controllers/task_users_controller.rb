# frozen_string_literal: true

class TaskUsersController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    user: :all,
    manager: :all
  )
  before_action :block_access_to_admin # authorization_persona
  before_action :set_user_to_add, only: [:create]
  before_action :valid_user, only: [:create]
  before_action :set_task_user, only: [:destroy]

  def create
    task_user = TaskUser.create(user: @user_to_add, task_id: params[:task_id])
    if task_user.save
      flash[:notice] = 'User add to task'
    else
      flash[:alert] = 'Error on adding user to task'
    end
    redirect_to task_path(params[:task_id])
  end

  def destroy
    if @task_user.destroy
      flash[:notice] = 'User is not longer assigned to the task'
    else
      flash[:alert] = 'There was an error'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_task_user
    @task_user = TaskUser.find(params[:id])
  end

  def set_user_to_add
    @user_to_add = User.find_by(email: params[:email])
  end

  def valid_user # and fat model, skinny controller?
    task = Task.find(params[:task_id])
    if @user_to_add.nil?
      flash[:alert] = 'The email does not belongs to any user' # this should have been done through validations
      redirect_to task_path(task)
    elsif @user_to_add.user_on_task?(task)
      flash[:alert] = 'The user already is assigned on the task' # again, through validations, you can add custom errors
      redirect_to task_path(task)
    elsif !@user_to_add.is_manager_or_manager_team?(task.board.author)
      flash[:alert] = 'You cannot add a user that is not member of your team' # validations
      redirect_to task_path(task)
    end
  end
end
