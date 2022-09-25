class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_article, only: [:destroy]
  before_action :require_same_user, only: [:destroy]

  def index
    @boards = current_user.boards
  end

  def destroy
    if @board.destroy
      flash[:notice] = 'Board was deleted'
    else
      flash[:alert] = 'Something went wrong'
    end

    redirect_to boards_path, status: :see_other
  end

  def show; end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.author = current_user

    if @board.save
      flash[:notice] = 'A new board was created'
      redirect_to boards_path
    else
      flash.now[:alert] = 'There was an error creating the board'
      render 'new'
    end
  end

  private

  def set_article
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title)
  end

  def require_same_user
    unless @board.author == current_user
      flash[:alert] = 'You can only delete your own boards'
      redirect_to boards_path
    end
  end
end
