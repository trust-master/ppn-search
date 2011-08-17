class ApplicationController < ActionController::Base
    before_filter :set_logged_in_user

private    
    def must_be_admin
        return redirect_to "/?return_uri=#{request.request_uri}" if @logged_in_user.nil?
        raise "You are not authorized to use this functionality." unless @logged_in_user.is_admin
    end
    def set_logged_in_user
        @logged_in_user = session[:user_id].nil? ? nil : User.find(session[:user_id])
    end
end
