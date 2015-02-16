class UsersController < ApplicationController
  # inherited resources
  # belongs_to :company
  # actions :all, except: [:show]

  # CanCan
  load_and_authorize_resource :company
  load_and_authorize_resource through: :company

  layout 'companies'

  respond_to :html, :json

  def update
    if @user.update_attributes(params[:user])
      redirect_to company_users_path(@company)
    else
      respond_to do |format|
        format.html {
          render('edit')
        }
      end
    end
  end

  def create
    if @user = @company.users.create(params[:user])
      redirect_to company_users_path(@company)
    else
      respond_to do |format|
        format.html {
          render 'new'
        }
      end
    end
  end

  def destroy
    @user.destroy!
    redirect_to company_users_path(@company)
  end

end
