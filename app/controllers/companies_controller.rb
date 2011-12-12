class CompaniesController < ApplicationController
  load_and_authorize_resource

  def create
    respond_to do |wants|
      if @company.save
        wants.html { redirect_to @company }
        wants.json { render json: { success: true, company_id: @company.id } }
      else
        wants.html { render :new }
        wants.json { render json: { success: false, message: @company.errors } }
      end
    end
  end

  def index
    respond_to do |wants|
      wants.html
      wants.json { render json: @company }
    end
  end

  def show
  end

  def new
    respond_to do |wants|
      wants.html
      wants.json { render json: @company }
    end
  end

  def edit

  end

  def search

  end

  def update

    respond_to do |wants|
      if @company.update_attributes(params[:company])
        wants.html { redirect_to @company }
        wants.json { render json: { success: true } }
      else
        wants.html { render :edit }
        wants.json { render json: { success: false, message: @company.errors } }
      end
    end
  end

  def destroy
    @company.destroy

    respond_to do |wants|
      wants.html { redirect_to companies_url }
    end
  end

end
