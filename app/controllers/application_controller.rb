class ApplicationController < ActionController::Base
  before_filter :set_current_user_in_user_model

  private

  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end
  helper_method :current_user

  def set_current_user_in_user_model
    User.current_user = current_user # set this to the User.current_user class variable to make sure user updates have
  end                                # access to the who who initated the update

end
