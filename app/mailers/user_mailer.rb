# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'from@example.com'
  layout 'mailer'

  def board_deleted(user, board_title)
    @board_title = board_title
    mail(to: user.email, subject: 'Board deletetion notification') do |f|
      f.html
    end
  end

  def board_updated(user, board_title)
    @board_title = board_title
    mail(to: user.email, subject: 'Board update notification') do |f|
      f.html
    end
  end

  def board_created(user, board_title)
    @board_title = board_title
    mail(to: user.email, subject: 'Board creation notification') do |f|
      f.html
    end
  end
end
