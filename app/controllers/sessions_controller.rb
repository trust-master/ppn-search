class SessionsController < ApplicationController
  load_resource

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
        format.html { redirect_to root_url, notice: 'Successfully logged in.' }
      else
        format.html { render action: "new", error: "Problem with email or password." }
      end
    end
  end

  def delete
    reset_session # wipes out everything during logout

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end

end
