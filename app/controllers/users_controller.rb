require_relative '../../lib/oauth/oauth2_client.rb'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  before_action :init_oauth_client, only: [:show]

  def show
    @user_photos = current_user.photos.with_attached_photo_file.order('id desc')
    @tweet_oauth_link = @client.authorize_url
    @tweet_token_present = session[:tweet_token].present?
  end

  def edit
  end

  private

  def set_user
    @user = current_user
  end

  def init_oauth_client
    @client = Oauth2Client.new(
      Rails.configuration.x.oauth.client_id,
      Rails.configuration.x.oauth.client_secret,
      authorize_url: '/oauth/authorize',
      site: Rails.configuration.x.oauth.idp_url,
      redirect_uri: Rails.configuration.x.oauth.redirect_uri
    )
  end

end
