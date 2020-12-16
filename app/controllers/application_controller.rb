class ApplicationController < ActionController::Base
  before_action :authorize_admin!
  def index
    redirect_to photos_path
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_admin!
    redirect_to login_path unless current_user
  end
end
