class AdminsController < ApplicationController
  authorize_persona class_name: "User"
  grant(
    admin: :all
  )

  def admin_menu
    @users = User.all
  end
end
