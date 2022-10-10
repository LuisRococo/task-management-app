class SecurityEmailBoardCreatedJob < ApplicationJob
  queue_as :default

  def perform(user, board_title)
    UserMailer.board_created(user, board_title).deliver
  end
end
