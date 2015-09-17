class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_admin

  def check_admin
  	redirect_to root_url unless session[:admin_id]
  end
end
