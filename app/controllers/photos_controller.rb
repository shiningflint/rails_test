class PhotosController < ApplicationController

  def create
    @photo = Photo.create(photo_params)
    unless @photo.errors.present?
      redirect_to user_path(id: photo_params[:user_id])
    else
      redirect_to(
        edit_user_path(id: photo_params[:user_id]),
        { flash: {
            error: @photo.errors.full_messages
          }
        }
      )
    end
  end

  private

  def photo_params
    params.permit(:user_id, :photo_file, :title)
  end

end
