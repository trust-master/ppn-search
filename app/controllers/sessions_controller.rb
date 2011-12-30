class SessionsController < ApplicationController
  #load_resource
  load_and_authorize_resource

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    user = User.find_by_email_and_password(@session.email, @session.password)
    session[:user_id] = user.id if user
    respond_to do |format|
      if user
        format.html { redirect_to root_url, notice: t('authentication.login.success') }
      else
        format.html { flash.now[:error] = t('authentication.login.failure'); render action: "new" }
      end
    end
  end

  def destroy
    reset_session # wipes out everything during logout

    respond_to do |format|
      format.html { redirect_to login_url, notice: t('authentication.logout.success') }
      format.json { head :ok }
    end
  end

end
