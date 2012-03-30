class ApplicationController < ActionController::Base
  before_filter :set_current_user_in_user_model
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    if current_user # not authorized
      redirect_to(root_url, alert: exception.message)

    else # not logged in
      url = (respond_to?(:main_app) ? main_app : self).login_path
      redirect_to(url)
    end
  end

  private

  def current_user
    @current_user ||= session[:user_id] ? User.where(id: session[:user_id]).first : nil
  end
  helper_method :current_user

  def current_user_admin?
    current_user.is_a?(Administrator) or raise CanCan::AccessDenied, t('unauthorized.not_an_admin', default: 'You are not an Admin!')
  end

  def set_current_user_in_user_model
    # set this to the User.current_user class variable to make sure user updates have
    # access to the who who initated the update
    User.current_user = current_user
  end

  def set_random_flash
    bucket = [:notice, :warning, :error, :alert].sample
    flash[bucket] = "Sample of #{bucket} flash"
  end
end
