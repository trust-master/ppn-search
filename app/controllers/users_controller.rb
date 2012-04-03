class UsersController < InheritedResources::Base
  # inherited resources
  belongs_to :company
  actions :all, except: [:show]

  # CanCan
  load_and_authorize_resource :company
  load_and_authorize_resource through: :company

  layout 'companies'

  respond_to :html, :json

  # def index
  #   respond_with @users do |wants|
  #     wants.html
  #   end
  # end

  # def show
  #   respond_with @user do |wants|
  #     wants.html
  #   end
  # end

  # def new
  #   respond_with @user do |wants|
  #     wants.html
  #   end
  # end

  # def create
  #   respond_with @user do |wants|
  #     if @user.save
  #       flash[:notice] = 'User was successfully created.'
  #       wants.html { redirect_to(@user) }
  #     else
  #       wants.html { render action: "new" }
  #     end
  #   end
  # end

  # def edit
  # end

  # def update
  #   respond_with @user do |wants|
  #     # @user.updated_by = request.remote_addr
  #     if @user.update_attributes(params[:user], as: current_user.role.underscore.to_sym)
  #       flash[:notice] = 'User was successfully updated.'
  #       wants.html { redirect_to([@company, :users]) }
  #     else
  #       wants.html { render action: "edit" }
  #     end
  #   end
  # end

  # def destroy
  #   @user.destroy
  #   respond_with @user
  # end

end
