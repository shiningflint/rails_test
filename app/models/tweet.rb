class Tweet
  attr_reader :errors

  def initialize (title, photo_url, token)
    @title = title
    @photo_url = photo_url
    @token = token
    @api_url = 'https://arcane-ravine-29792.herokuapp.com/api/tweets'
    @errors = []
  end

  def create
    response = Faraday.post(
      @api_url,
      body,
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@token}"
    )

    unless response.status == 201
      @errors << 'ツイートすることが失敗しました'
    end
  end

  private

  def body
    { text: @title, url: @photo_url }.to_json
  end

end
