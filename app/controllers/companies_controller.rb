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
    @personal_license = @company.personal_license.build

    respond_to do |wants|
      wants.html
      wants.json { render json: @company }
    end
  end

  def edit
    @company.build_personal_license if @company.personal_license.nil?
    @company.build_business_license if @company.business_license.nil?
    @company.build_business_filing if @company.business_filing.nil?
    @company.affiliations.build if @company.affiliations.empty?
    @company.associations.build if @company.associations.empty?
    @company.certifications.build if @company.certifications.empty?
    @company.locations.build if @company.locations.empty?

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
