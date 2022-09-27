class TaskListsController < ApplicationController
  before_action :validate_board_url_param_id, only: [:new, :index]
  before_action :set_board_from_url_param, only: [:new, :index]
  before_action :validate_board_param, only: [:create]
  before_action :set_task_list, only: [:show, :destroy, :edit, :update]

  def index
    @task_lists = @board.task_lists.all
  end

  def show
  end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(task_list_params)
    if @task_list.save
      flash[:notice] = 'Task list created'
      redirect_to board_path(@task_list.board.id)
    else 
      flash.now[:alert] = 'There was an error'
      render 'new'
    end
  end

  def destroy
    if @task_list.destroy
      flash[:notice] = 'Task list was destroyed successfuly'
    else
      flash[:alert] = 'There was an error on deleting the task list'
    end
    redirect_to task_lists_path(board_id: @task_list.board.id)
  end

  def edit
  end

  def update
    if @task_list.update(task_list_params)
      flash[:notice] = 'Task list was updated successfully'
      redirect_to task_list_path(board_id: @task_list.board.id)
    else
      flash.now[:alert] = 'There was an error'
      render 'edit'
    end
  end

  private 

  def validate_board_url_param_id
    unless valid_board?(params[:board_id])
      flash[:alert] = 'The board you are trying to access is not valid'
      redirect_to boards_path
    end
  end

  def validate_board_param
    unless valid_board?(params[:task_list][:board_id])
      flash[:alert] = 'The board you are trying to access is not valid'
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

  def set_task_list
    @task_list = TaskList.find(params[:id])
  end
end
