class TasksController < ApplicationController
  before_action :set_task_list, only: [:new, :create]
  before_action :set_task, only: [:edit, :update]
  before_action :task_params, only: [:create]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user
    @task.task_list_id = params[:task_list_id]
    if @task.save
      flash[:notice] = 'Task saved successfully'
      redirect_to board_path(@task_list.board)
    else
      flash.now[:alert] = 'There was an error on saving the task'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task updated successfully'
      redirect_to board_path(@task.board)
    else
      flash[:alert] = 'There was an error'
      render 'edit'
    end
  end

  private

  def set_task_list
    @task_list = TaskList.find_by_id(params[:task_list_id])
  end

  def task_params
    params.require(:task).permit(:title, :task_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
