class SecurityEmailBoardDeleteJob < ApplicationJob
  queue_as :default

  def perform(user, board_title)
    UserMailer.board_deleted(user, board_title).deliver
  end
end
