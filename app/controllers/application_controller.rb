class ApplicationController < ActionController::Base

  private

  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end


end
