class TasksController < ApplicationController
  before_action :set_board_from_url, only: [:new]
  before_action :set_board_from_params, only: [:create]
  before_action :valid_board?, only: [:new, :create]
  before_action :task_params, only: [:create]

  def new
    @task = Task.new
    @task_lists = @board.task_lists
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user
    if @task.save
      flash[:notice] = 'Task saved successfully'
      redirect_to board_path(@board)
    else
      flash.now[:alert] = 'There was an error on saving the task'
      @task_lists = @board.task_lists
      render 'new'
    end
  end

  private

  def valid_board?()
    if @board.nil?
      flash[:alert] = 'That board is not valid'
      redirect_to boards_path
    end
  end

  def set_board_from_url
    @board = Board.find_by_id(params[:board_id])
  end

  def set_board_from_params
    @board = Board.find_by_id(params[:board_id])
  end

  def task_params
    params.require(:task).permit(:title, :task_list_id, :task_id)
  end
end
