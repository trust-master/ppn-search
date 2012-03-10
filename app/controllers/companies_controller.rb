class CompaniesController < ApplicationController
  respond_to :html, :json, :yaml
  load_and_authorize_resource

  before_filter :build_associated_if_neccesary, only: %w[new edit]

  def index
    @companies = @companies.limit(5)
    @companies = @companies.where("name ILIKE ?", "%#{params[:search]}%") if params[:search] # FIXME: Implement real search

    respond_with @companies do |wants|
      wants.html { render :index, layout: 'application'}
      wants.json
    end
  end

  def show
    respond_with @company
  end

  def new
    respond_with @company
  end

  def create
    respond_with @company do |wants|
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
    respond_with @company do |wants|
      wants.html {
        render(params[:section] || :edit)
      }
    end
  end

  def update
    respond_with @company do |wants|
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
    # @company.personal_licenses.build if @company.personal_licenses.empty?
    # @company.business_licenses.build if @company.business_licenses.empty?
    # @company.build_business_filing   if @company.business_filing.nil?
    # @company.affiliations.build      if @company.affiliations.empty?
    # @company.associations.build      if @company.associations.empty?
    # @company.certifications.build    if @company.certifications.empty?
    # @company.locations.build         if @company.locations.empty?

    # REFACTOR: !!
    @markets = @company.company_service_areas.includes(service_area: :market).group_by(&:market)
    service_areas = ServiceArea.includes(:market)
    if ids = @markets.values.flatten.map(&:service_area_id).presence
      service_areas = service_areas.where('id NOT IN (?)', ids)
    end
    service_areas.each do |service_area|
      @markets[service_area.market] ||= []
      built = @company.company_service_areas.build(service_area: service_area)
      built.mark_for_destruction
      @markets[service_area.market] << built
    end

    @categories = @company.company_categories.includes(sub_category: :category).group_by(&:category)
    sub_categories = SubCategory.includes(:category)
    if ids = @categories.values.flatten.map(&:sub_category_id).presence
      sub_categories = sub_categories.where('id NOT IN (?)', ids)
    end
    sub_categories.each do |sub_category|
      @categories[sub_category.category] ||= []
      built = @company.company_categories.build(sub_category: sub_category)
      built.mark_for_destruction
      @categories[sub_category.category] << built
    end
  end

end
