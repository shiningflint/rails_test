require_relative '../../lib/utilities/json_utility.rb'
require_relative '../../lib/oauth/oauth2_client.rb'

class OauthController < ApplicationController
  # authorize url example that works
  # GET https://arcane-ravine-29792.herokuapp.com/oauth/authorize?client_id=boo&response_type=code&redirect_uri=http://localhost:3000/oauth/callback
  # idp params in redirect_uri, might be used for the future if we want more oauth providers in the future.
  # each with different strategies
  #
  # token example that works
  # https://arcane-ravine-29792.herokuapp.com/oauth/token?code=boo&client_id=boo&client_secret=boo&redirect_uri=http://localhost:3000/oauth/callback&grant_type=authorization_code

  def initialize
    @client = Oauth2Client.new(
      Rails.configuration.x.oauth.client_id,
      Rails.configuration.x.oauth.client_secret,
      site: Rails.configuration.x.oauth.idp_url,
      token_url: '/oauth/token',
      redirect_uri: Rails.configuration.x.oauth.redirect_uri,
    )
  end

  def oauth_callback
    response = @client.get_token(params[:code])

    if (response.status == 200 && JsonUtility.valid_json?(response.body))
      parsed_response = JSON.parse(response.body).symbolize_keys
      token = parsed_response[:access_token]
      session[:tweet_token] = token

      flash[:notice] = ['連携を成功しました!']
    else
      flash[:error] = ['連携を失敗しました。']
    end

    redirect_to user_path(current_user.id)
  end

end
