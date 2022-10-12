# frozen_string_literal: true

class BoardsController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    user: %i[show index toggle_visibility],
    manager: :all,
    admin: :all
  )
  before_action :block_access_to_admin # this should be managed by authorization_persona
  before_action :set_author_from_url, only: %i[index create new]
  before_action :set_board_from_url, only: %i[show edit update destroy toggle_visibility]
  before_action :set_author_from_board, except: %i[index new create]

  before_action :same_user_as_author, except: %i[index show toggle_visibility]
  before_action :part_of_team, only: %i[index toggle_visibility]
  before_action :access_to_board, only: [:show]

  def index
    @boards = @author.boards
    respond_to do |format|
      format.html
      format.json
    end
  end

  def destroy
    if @board.destroy
      if @board.author.board_delete_notification
        SecurityEmailBoardDeleteJob.perform_later(current_user,
                                                  @board.title)
      end
      flash[:notice] = 'Board was deleted'
    else
      flash[:alert] = 'Something went wrong'
    end

    redirect_to user_boards_path(current_user), status: :see_other
  end

  def show
    @task_lists = @board.task_lists
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.author = @author

    if @board.save
      flash[:notice] = 'A new board was created'
      if @board.author.board_create_notification
        SecurityEmailBoardCreatedJob.perform_later(current_user,
                                                    @board.title)
      end
      redirect_to board_path(@board)
    else
      flash.now[:alert] = 'There was an error creating the board'
      render 'new'
    end
  end

  def edit; end

  def update
    if @board.update(board_params)
      flash[:notice] = 'The board was successfully updated'
      if @board.author.board_update_notification
        SecurityEmailBoardUpdateJob.perform_later(current_user,
                                                @board.title)
      end
      redirect_to board_path(@board)
    else
      flash.now[:alert] = 'There was an error'
      render 'edit'
    end
  end

  def toggle_visibility
    @board.toggle_visibility
    flash[:notice] = 'The visibility of the board has changed'
    redirect_back(fallback_location: root_path)
  end

  private

  def set_board_from_url
    @board = Board.find(params[:id])
  end

  def set_author_from_url
    @author = User.find(params[:user_id])
  end

  def board_params
    params.require(:board).permit(:title)
  end

  def access_to_board
    unless @board.user_has_access?(current_user)
      flash[:alert] = 'You can only access boards that belongs to you or your team'
      redirect_to board_index_path(current_user)
    end
  end

  def part_of_team
    unless current_user.is_manager_or_manager_team?(@author)
      flash[:alert] = 'You can only access boards that belongs to you or your team'
      redirect_to board_index_path(current_user)
    end
  end

  def same_user_as_author
    unless current_user == @author
      flash[:alert] = 'You can only access boards that belongs to you'
      redirect_to board_index_path(current_user)
    end
  end

  # good example of a callback
  def set_author_from_board
    @author = @board.author
  end
end
