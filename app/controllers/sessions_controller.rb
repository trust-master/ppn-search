class SessionsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json, :yaml

  def new
    # redirect to a usable page, when already logged in.
    if current_user
      redirect_to companies_path
    else
      respond_with @session do |format|
        format.html
      end
    end
  end

  def create
    reset_session # wipes out any session that may have existed before attempt to log in

    user = User.find_by_email_and_password(@session.email, @session.password)
    session[:user_id] = user.id if user
    respond_with @session do |format|
      if user
        format.html { redirect_to companies_path, notice: t('success', scope: ['sessions.new']) }
      else
        format.html { flash.now[:error] = t('failure', scope: ['sessions.new']); render action: "new" }
      end
    end
  end

  def destroy
    reset_session # wipes out everything during logout

    respond_with @session do |format|
      format.html { redirect_to login_url, notice: t('success', scope: ['sessions.destroy']) }
      format.json { head :ok }
    end
  end

end
