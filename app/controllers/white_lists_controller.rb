# frozen_string_literal: true

class WhiteListsController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    admin: :all
  )
  before_action :set_target_user, except: [:index]
  before_action :target_user_admin, except: [:index]
  before_action :already_white_listed, only: [:create]

  def index
    @users = User.white_managers_white_list.paginate(page: params[:page], per_page: 10)
  end

  # also, please remember messages should be 
  # managed through internationalization
  def create
    @target_user.add_white_list
    flash[:notice] = 'User is now white listed'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @target_user.remove_white_list
    flash[:notice] = 'User is now not white listed'
    redirect_back(fallback_location: root_path)
  end

  private

  def set_target_user
    @target_user = User.find(params[:id])
  end

  def target_user_admin
    unless @target_user.authorization_tier == 'manager'
      flash[:alert] = 'User is not a manager' # this should have been done through authorization persona
      redirect_back(fallback_location: root_path)
    end
  end

  def already_white_listed
    if @target_user.white_listed?
      flash[:alert] = 'User is already white listed'
      redirect_back(fallback_location: root_path)
    end
  end
end
