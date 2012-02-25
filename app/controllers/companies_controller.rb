class CompaniesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
    build_associated_if_neccesary
  end

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

  def edit
    build_associated_if_neccesary
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

    redirect_to companies_url
  end

  private

  def build_associated_if_neccesary
    @company.personal_licenses.build if @company.personal_licenses.empty?
    @company.business_licenses.build if @company.business_licenses.empty?
    @company.build_business_filing   if @company.business_filing.nil?
    @company.affiliations.build      if @company.affiliations.empty?
    @company.associations.build      if @company.associations.empty?
    @company.certifications.build    if @company.certifications.empty?
    @company.locations.build         if @company.locations.empty?
  end

end
