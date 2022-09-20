class ApplicationController < ActionController::Base
  include AuthorizedPersona::Authorization
  
  before_action :authenticate_user!
end
