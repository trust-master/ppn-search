class UsersController < ApplicationController
  load_and_authorize_resource

  def create
    respond_to do |wants|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        wants.html { redirect_to(@user) }
      else
        wants.html { render :action => "new" }
      end
    end
  end

  def destroy
    @user.destroy
  end

  def edit
  end

  def index
    respond_to do |wants|
      wants.html
    end
  end

  def new
    respond_to do |wants|
      wants.html
    end
  end

  def show
    respond_to do |wants|
      wants.html
    end
  end

  def update
    respond_to do |wants|
      @user.updated_by = request.remote_addr
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        wants.html { redirect_to(@user) }
      else
        wants.html { render :action => "edit" }
      end
    end
  end

end
