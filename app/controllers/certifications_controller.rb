class CertificationsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :certification, through: :company

  layout 'companies'

  def create
    if @certification.save
      render json: { success: true, certification: @certification }
    else
      render json: { success: false, message: @certification.errors }
    end
  end

  def new
  end

  def index
  end

  def update
    if @certification.update_attributes(params[:certification])
      render json: {success: true, certification: @certification }
    else
      render json: {success: false, message: @certification.errors }
    end
  end

  def destroy
    @certification.destroy
    render json: { success: true }
  end

end
