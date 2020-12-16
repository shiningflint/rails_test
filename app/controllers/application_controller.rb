class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize_admin!

  def index
    redirect_to photos_path
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # TODO: write test for photos page redirection
  def authorize_admin!
    redirect_to login_path unless current_user
  end
end
