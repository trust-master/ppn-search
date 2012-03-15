class AffiliationsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :affiliation, through: :company

  def create
    if @affiliation.save
      render json: { success: true, affiliation: @affiliation }
    else
      render json: { success: false, message: @affiliation.errors }
    end
  end

  def index
  end

  def new
  end

  def update
    if @affiliation.update_attributes(params[:affiliation])
      render json: { success: true, affiliation: @affiliation }
    else
      render json: { success: false, message: @affiliation.errors }
    end
  end

  def destroy
    @affiliation.destroy
    render json: { success: true }
  end

end
