class UsersController < ApplicationController
  authorize_persona class_name: "User"
  grant(
    user: :all,
    manager: :all,
    admin: :all,
  )

  before_action :set_user, only: [:show]

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
