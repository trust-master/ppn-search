class UserObserver < ActiveRecord::Observer
  observe :user

  def after_create(user)
    UserActivationToken.create!({user_id: user}, without_protection: true)
  end

end