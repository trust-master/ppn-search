class ApplicationController < ActionController::Base
  before_filter :set_current_user_in_user_model
  # before_filter :set_random_flash
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    if current_user # not authorized
      redirect_to root_url, :alert => exception.message
    else # not logged in
      redirect_to login_path #, :alert => I18n.t('unauthorized.not_authenticated')
    end
  end

  private

  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end
  helper_method :current_user

  def set_current_user_in_user_model
    User.current_user = current_user # set this to the User.current_user class variable to make sure user updates have
                                     # access to the who who initated the update
  end

  def set_random_flash
    bucket = [:notice, :warning, :error, :alert].sample
    flash[bucket] = "Sample of #{bucket} flash"
  end
end
