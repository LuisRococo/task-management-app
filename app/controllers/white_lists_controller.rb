# frozen_string_literal: true

class WhiteListsController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    admin: :all
  )

  def index
    @users = User.where(white_listed: true).paginate(page: params[:page], per_page: 10)
  end
end
