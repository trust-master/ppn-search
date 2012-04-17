class UserAuthTokenObserver < ActiveRecord::Observer

  def after_create(token)
    token.mailer.deliver
  end

end