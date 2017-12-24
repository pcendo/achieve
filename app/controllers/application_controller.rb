class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :login_check
  
  def login_check
    if logged_in?
      @msg = "Current user:"+current_user.name
    else
    end
  end    
  
end
