class ApplicationController < ActionController::Base
  before_filter :set_current_user_in_user_model

  protect_from_forgery
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    if current_user # not authorized
      redirect_to(root_url, alert: exception.message)
      logger.info "Unauthorized: #{exception.subject.name}:#{exception.action}"
    else # not logged in
      url = (respond_to?(:main_app) ? main_app : self).login_path
      redirect_to(url)
    end
  end

  private

  def current_user
    @current_user ||= if session[:user_id]
      User.where(id: session[:user_id]).first
    elsif user = authenticate_with_http_basic { |email, password| User.find_by_email_and_password(email, password) }
      user
    else
      nil
    end
  end
  helper_method :current_user

  def current_user_admin?
    unless current_user.is_a?(Administrator)
      raise CanCan::AccessDenied, t('unauthorized.not_an_admin', default: 'You are not an Admin!')
    end
  end

  def set_current_user_in_user_model
    # set this to the User.current_user class variable to make sure user updates have
    # access to the who who initated the update
    User.current_user = current_user
  end

  # PaperTrail will use these
  def info_for_paper_trail
    { ip_address: request.remote_ip, controller_name: self.class.name }
  end
  # alias :user_for_paper_trail :current_user

end
