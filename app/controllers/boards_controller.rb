class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @boards = current_user.boards
  end

  def show; end
end
