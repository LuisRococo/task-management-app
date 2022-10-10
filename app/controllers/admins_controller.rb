# frozen_string_literal: true

class AdminsController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    admin: :all
  )

  def admin_menu
    @users = User.paginate(page: params[:page], per_page: 10)
  end
end
