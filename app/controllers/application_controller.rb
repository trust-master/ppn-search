class ApplicationController < ActionController::Base
  before_filter :set_current_user_in_user_model
  # before_filter :set_random_flash
  check_authorization unless: :rails_admin_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if current_user # not authorized
      redirect_to(root_url, alert: exception.message)

    else # not logged in
      redirect_to(rails_admin_controller? ? main_app.login_path : login_path)
    end
  end

  private

  def current_user
    @current_user ||= session[:user_id] ? User.where(id: session[:user_id]).first : nil
  end
  helper_method :current_user

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
