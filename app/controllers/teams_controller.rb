class TeamsController < ApplicationController
  authorize_persona class_name: "User"
  before_action :validate_already_existing_user, only: [:create]
  grant(
    admin: :all,
    manager: :all
  )

  def new
  end

  def create
    User.invite! email: params[:email],
                  first_name: params[:first_name],
                  last_name: params[:last_name],
                  authorization_tier: :user,
                  manager: current_user
    flash[:notice] = "The invitation was send to #{params[:email]}"
    redirect_back(fallback_location: root_path)
  end

  private

  def validate_already_existing_user
    user_found = User.find_by(email: params[:email])
    if user_found
      flash[:alert] = 'That emails is already associated to a team'
      redirect_back(fallback_location: root_path)
    end
  end
end
