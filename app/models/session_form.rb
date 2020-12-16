class SessionForm

  attr_reader :errors

  def initialize (params)
    @params = params
    @errors = []
  end

  def validate!
    unless @params[:name].present?
      user_id = I18n.t 'activerecord.attributes.user.name'
      user_id_blank = I18n.t 'activerecord.errors.models.user.attributes.name.blank'
      @errors << "#{user_id}#{user_id_blank}"
    end

    unless @params[:password].present?
      password = I18n.t 'activerecord.attributes.user.password'
      password_blank = I18n.t 'activerecord.errors.models.user.attributes.password.blank'
      @errors << "#{password}#{password_blank}"
    end

    true unless @errors.any?
  end

end
