class TaskListsController < ApplicationController
  before_action :validate_board_url_param_id, only: [:new]
  before_action :set_board_from_url_param, only: [:new]
  before_action :validate_board_param, only: [:create]

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(task_list_params)
    if @task_list.save
      flash[:notice] = 'Task list created'
      redirect_to board_path(params[:task_list][:board_id])
    else 
      flash.now[:alert] = 'There was an error'
      render 'new'
    end
  end

  private 

  def validate_board_url_param_id
    unless valid_board?(params[:board_id])
      flash[:alert] = 'The board you are trying to modify is not valid'
      redirect_to boards_path
    end
  end

  def validate_board_param
    unless valid_board?(params[:task_list][:board_id])
      flash[:alert] = 'The board you are trying to modify is not valid'
      redirect_to boards_path
    end
  end

  def valid_board?(id)
    current_user.boards.where(id: id).exists?
  end

  def task_list_params
    params.require(:task_list).permit(:name, :color, :priority, :board_id)
  end

  def set_board_from_url_param
    @board = Board.find(params[:board_id])
  end
end
