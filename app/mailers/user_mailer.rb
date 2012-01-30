class UserMailer < ActionMailer::Base
  default from: "support@localhost"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user_auth_token)
    @link = password_reset_url(user_auth_token)
    user = user_auth_token.user
    @user_name = user.display_name
    mail(to: user.email)
  end
end
