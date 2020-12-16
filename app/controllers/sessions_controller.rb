class SessionsController < ApplicationController
  skip_before_action :authorize_admin!

  layout 'session'

  def new
  end

  # Check the form user input first
  # Then validate the user
  def create
    @session_form = SessionForm.new(session_params)

    unless @session_form.validate!
      @validation_errors = @session_form.errors
      render 'new' and return
    end

    @user = User.find_by(name: session_params[:name])

    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to photos_path
    else
      @validation_errors = ['ユーザーIDまたはパスワードが間違っています']
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def session_params
    params.permit(:name, :password)
  end

end
