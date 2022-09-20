class ApplicationController < ActionController::Base
  include AuthorizedPersona::Authorization
  
  before_action :authenticate_user!

  authorize_persona class_name: "User"
end
