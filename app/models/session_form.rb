class SessionForm
  attr_reader :errors

  def initialize (params)
    @params = params
    @errors = []
  end

  def validate!
    # TODO: Use translated model names in I18n object in the future
    unless @params[:name].present?
      @errors << 'ユーザーIDを入力して下さい！'
    end

    unless @params[:password].present?
      @errors << 'パスワードを入力して下さい！'
    end

    true unless @errors.any?
  end

end
