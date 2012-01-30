class SessionsController < ApplicationController
  #load_resource
  load_and_authorize_resource

  def new
    # redirect to a usable page, when already logged in.
    if current_user
      redirect_to companies_path
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    reset_session # wipes out any session that may have existed before attempt to log in

    user = User.find_by_email_and_password(@session.email, @session.password)
    session[:user_id] = user.id if user
    respond_to do |format|
      if user
        format.html { redirect_to companies_path, notice: t('session.new.success') }
      else
        format.html { flash.now[:error] = t('session.new.failure'); render action: "new" }
      end
    end
  end

  def destroy
    reset_session # wipes out everything during logout

    respond_to do |format|
      format.html { redirect_to login_url, notice: t('session.destroy.success') }
      format.json { head :ok }
    end
  end

end
