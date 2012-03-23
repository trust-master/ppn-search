class UsersController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource through: :company


  layout 'companies'

  respond_to :html, :json

  def create
    respond_with @user do |wants|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        wants.html { redirect_to(@user) }
      else
        wants.html { render action: "new" }
      end
    end
  end

  def destroy
    @user.destroy
    respond_with @user
  end

  def edit
  end

  def index
    respond_with @user do |wants|
      wants.html
    end
  end

  def new
    respond_with @user do |wants|
      wants.html
    end
  end

  def show
    respond_with @user do |wants|
      wants.html
    end
  end

  def update
    respond_with @user do |wants|
      @user.updated_by = request.remote_addr
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        wants.html { redirect_to(@user) }
      else
        wants.html { render action: "edit" }
      end
    end
  end

end
