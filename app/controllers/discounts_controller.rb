class DiscountsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :discount, through: :company

  layout 'companies'

  respond_to :html, :json

  def index
    respond_with @discounts do |wants|
      wants.html
      wants.json
    end
  end


  def new
  end

  def create
    respond_with @discount do |wants|
      if @discount.save
        wants.html do
          flash[:notice] = 'Discount created successfully.'
          redirect_to([@company, @discount])
        end
        wants.json do
          render json: { success: true }
        end
      else
        wants.html do
          flash.now[:error] = 'There was a problem saving, please check below for error messages.'
          new
        end
        wants.json do
          render json: { success: false, message: @discount.errors }
        end
      end
    end
  end

  def edit
  end

  def update
    respond_with @discount do |wants|
      if @discount.update_attributes(params[:discount])
        wants.html do
          flash[:notice] = 'Discount saved successfully.'
          redirect_to([@company, @discount])
        end
        wants.json do
          render json: { success: true }
        end
      else
        wants.html do
          flash.now[:error] = 'There was a problem saving, please check below for error messages.'
          edit
        end
        wants.json do
          render json: { success: false, message: @discount.errors }
        end
      end
    end
  end

  def destroy
    if @discount.destroy
      flash.notice = 'Deleted Discount successfully'
    else
      flash.error = 'Problem deleting Discount'
    end
    redirect_to [@company, :discounts]
  end
end
