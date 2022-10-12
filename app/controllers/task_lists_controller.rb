# frozen_string_literal: true

class TaskListsController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    user: :all,
    manager: :all
  )

  before_action :block_access_to_admin # this should have been done through authorization_persona
  before_action :set_board_from_url_param, only: %i[new index create]
  before_action :set_task_list, except: %i[index new create]

  # a lot of validations here
  before_action :validate_board_url_param_id, only: %i[new index create]
  before_action :validate_board_param, only: [:create]

  before_action :validate_task_list, only: %i[edit update destroy show]

  def index
    @task_lists = @board.task_lists
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show; end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.board_id = @board.id
    if @task_list.save
      flash[:notice] = 'Task list created'
      redirect_to board_path(@task_list.board)
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
    redirect_to board_task_lists_path(@task_list.board)
  end

  def edit; end

  def update
    if @task_list.update(task_list_params)
      flash[:notice] = 'Task list was updated successfully'
      redirect_to board_task_lists_path(@task_list.board)
    else
      flash.now[:alert] = 'There was an error'
      render 'edit'
    end
  end

  private

  # again, the following two methods are just
  # the same but named differently
  def validate_board_url_param_id
    unless valid_board?(params[:board_id])
      flash[:alert] = 'The board you are trying to access is not valid'
      redirect_to board_index_path(current_user)
    end
  end

  def validate_board_param # this could have done through halting with an exception rescue 
    # rescue_from at the beginning, while doing a board.find() and if it throws an error
    # you would have been able to catch it with the rescue_from 
    # and the method could redirect_back with the alert
    unless valid_board?(params[:board_id])
      flash[:alert] = 'The board you are trying to access is not valid'
      redirect_to board_index_path(current_user)
    end
  end

  def valid_board?(id)
    board = Board.find_by(id: id)
    return false unless board # something like this

    current_user.is_manager_or_manager_team?(board.author)
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

  def validate_task_list
    unless current_user.is_manager_or_manager_team?(@task_list.board.author)
      flash[:alert] = 'You cannot access that task list'
      redirect_back(fallback_location: root_path)
    end
  end
end
