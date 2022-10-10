class SecurityEmailBoardUpdateJob < ApplicationJob
  queue_as :default

  def perform(user, board_title)
    UserMailer.board_updated(user, board_title).deliver
  end
end
