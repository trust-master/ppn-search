class UserAuthTokenMailer < ActionMailer::Base
  layout 'mailer'

  default from: "#{smtp_settings[:from] || 'Trust Master'} <#{smtp_settings[:user_name] || 'info@trust-master.com'}>"

  def user_activation_token(token, opts = {})
    setup(token)
    @link = activate_url(token)
    pack_token(mail(opts.merge(to: @to)))
  end

  def user_reactivation_token(token, opts = {})
    setup(token)
    @link = activate_url(token)
    pack_token(mail(opts.merge(to: @to)))
  end

  def password_reset(token, opts = {})
    setup(token)
    @link = password_reset_url(token)
    pack_token(mail(opts.merge(to: @to)))
  end

  private

  def setup(token)
    @token = token
    @user_name = token.user.first_name
    @to = token.user.email
  end

  def pack_token(mailer)
    mailer.instance_variable_set(:@token, @token)
    return mailer
  end

end
