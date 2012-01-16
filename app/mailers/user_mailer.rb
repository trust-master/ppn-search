class UserMailer < ApplicationMailer
  default from: "support@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user_auth_token)
    @auth_token = user_auth_token
    @user = @auth_token.user
  end
end
