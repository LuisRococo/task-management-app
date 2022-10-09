# frozen_string_literal: true

class TeamsController < ApplicationController
  authorize_persona class_name: 'User'
  before_action :validate_already_existing_user, only: [:create]
  before_action :same_user, only: %i[create new index]
  grant(
    manager: :all
  )

  def index
    @team = current_user.team_members
  end

  def new; end

  def create
    if current_user.max_team_members_reached?
      flash[:alert] = 'You are not allow to add more members to your team!'
    else
      User.invite! email: params[:email],
                   first_name: params[:first_name],
                   last_name: params[:last_name],
                   authorization_tier: :user,
                   manager: current_user
      flash[:notice] = "The invitation was send to #{params[:email]}"
    end
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

  def same_user
    unless current_user.id == params[:user_id].to_i
      flash[:alert] = 'You are not allowed to access this url'
      redirect_to root_path
    end
  end
end
