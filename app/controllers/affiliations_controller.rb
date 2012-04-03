class AffiliationsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :affiliation, through: :company

  layout 'companies'

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
    if @affiliation.update_attributes(params[:affiliation], as: current_user.role.underscore.to_sym)
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
