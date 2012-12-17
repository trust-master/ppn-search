class UserAuthTokenObserver < ActiveRecord::Observer
  observe :user_auth_token, :user_activation_token, :user_reactivation_token, :password_reset

  def after_create(token)
    token.mailer.deliver
  end

  def fullfill!(token)
    if token.is_a?(UserActivationToken)
      token.user.try(:activate!)

      AdminMailer.user_activated(token).deliver
    end
  end

end