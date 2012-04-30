class UserAuthTokenObserver < ActiveRecord::Observer
  observe :user_auth_token, :user_activation_token, :user_reactivation_token, :password_reset

  def after_create(token)
    token.mailer.deliver
  end

end