class AssociationsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :association, through: :company

  def create
    if @association.save
      render :json => { :success => true, :association => @association }
    else
      render :json => { :success => false, :message => @association.errors }
    end
  end

  def index
  end

  def new
  end

  def update
    if @association.update_attributes(params[:association])
      render :json => {:success => true, :association => @association }
    else
      render :json => {:success => false, :message => @association.errors }
    end
  end

  def destroy
    @association.destroy
    render :json => { :success => true }
  end
end
