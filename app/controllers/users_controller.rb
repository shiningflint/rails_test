class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit]

  def show
    @user_photos = @user.photos.with_attached_photo_file.order('id desc')
  end

  def edit
  end

  private

  def get_user
    @user = User.find_by(id: params[:id])
  end

end
