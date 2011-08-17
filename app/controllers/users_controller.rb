class UsersController < ApplicationController
    before_filter :find_user, :only => [:show, :edit, :update, :destroy]
    before_filter :must_be_admin, :except => [ :login, :logout ]
    def create
        @user = User.new(params[:user])

        respond_to do |wants|
            if @user.save
                flash[:notice] = 'User was successfully created.'
                wants.html { redirect_to(@user) }
                wants.xml  { render :xml => @user, :status => :created, :location => @user }
            else
                wants.html { render :action => "new" }
                wants.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
            end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.xml
    def destroy
        begin
            raise "Could not locate the specified user" if @user.nil?
            raise "You cannot delete your own user" if @user.id == @logged_in_user.id
            @user.destroy
            head :ok
        rescue Exception => ex
            render :text => ex.message, :status => 500
            return
        end
    end

    # GET /users/1/edit
    def edit
    end

    # GET /users
    # GET /users.xml
    def index
        @users = User.all

        respond_to do |wants|
            wants.html # index.html.erb
            wants.xml  { render :xml => @users }
        end
    end
    def login
        @return_uri = params[:return_uri]
        unless @logged_in_user.nil?
            redirect_to @logged_in_user.is_admin ? "/users/" : "/somewhre"
            return
        end
        unless params[:user]
            @user = User.new
            return
        end
        user = User.authenticate(params[:user][:email_address], params[:user][:password])
        if user.nil?
            @user = User.new(params[:user])
            flash[:notice] = "Invalid email address / password."
            return
        end
        session[:user_id] = user.id
        redirect_to @return_uri.nil? ? "/users/" : @return_uri
    end
    def logout
        session[:user_id] = nil
        flash[:notice] = "You have been logged out.  Thank you for using Trustmaster."
        redirect_to "/users/login"
    end
    
    # GET /users/new
    # GET /users/new.xml
    def new
        @user = User.new

        respond_to do |wants|
            wants.html # new.html.erb
            wants.xml  { render :xml => @user }
        end
    end
    # GET /users/1
    # GET /users/1.xml
    def show
        respond_to do |wants|
            wants.html # show.html.erb
            wants.xml  { render :xml => @user }
        end
    end

    # PUT /users/1
    # PUT /users/1.xml
    def update
        respond_to do |wants|
            @user.updated_by = request.remote_addr
            if @user.update_attributes(params[:user])
                flash[:notice] = 'User was successfully updated.'
                wants.html { redirect_to(@user) }
                wants.xml  { head :ok }
            else
                wants.html { render :action => "edit" }
                wants.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
            end
        end
    end
    def validate_email_is_unique
        @user = User.find_by_email_address params[:user][:email_address]
        respond_to do |wants|
            wants.json { render :json => @user.nil? }
        end
    end
private
    def find_user
        @user = User.find(params[:id])
    end
end
