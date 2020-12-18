class Oauth2Client
  def initialize (client_id, client_secret, options)
    @client_id = client_id
    @client_secret = client_secret
    @authorize_url = options[:authorize_url] || nil
    @site = options[:site] || nil
    @token_url = options[:token_url] || nil
    @redirect_uri = options[:redirect_uri] || nil
    @params = options[:params] || nil
  end

  def authorize_url
    query = {
      client_id: @client_id,
      response_type: 'code',
      redirect_uri: @redirect_uri
    }
    "#{@site}#{@authorize_url}?#{query.to_query}"
  end

  def get_token (code)
    uri = "#{@site}#{@token_url}"
    params = {
      code: code,
      client_id: @client_id,
      client_secret: @client_secret,
      redirect_uri: @redirect_uri,
      grant_type: 'authorization_code'
    }
    Faraday.post(uri, params)
  end
end
