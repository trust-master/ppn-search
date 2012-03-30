class CompaniesController < ApplicationController
  respond_to :html, :json, :yaml
  load_and_authorize_resource

  attr_accessor :company, :markets, :categories

  # before_filter :build_associated_if_neccesary, only: %w[new edit]
  before_filter CompaniesFilters::SetUpMarkets, CompaniesFilters::SetUpCategories, only: %w[new edit]

  layout 'companies'

  def index
    @companies = CompanySearch.new(params[:name], params[:sub_category])
    @companies = @companies.limit(params[:per_page] || 5)
    @companies = @companies.where(active: true, visible: true) unless current_user.is_a?(Administrator)

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
        wants.html do
          flash[:notice] = 'Company created successfully.'
          redirect_to @company
        end
        wants.json do
          render json: { success: true }
        end
      else
        wants.html do
          build_associated_if_neccesary
          set_up_service_associations_if_neccesary
          flash.now[:error] = 'There was a problem saving, please check below for error messages.'
          new
        end
        wants.json do
          render json: { success: false, message: @company.errors }
        end
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
        wants.html do
          flash[:notice] = 'Company saved successfully.'
          redirect_to @company
        end
        wants.json do
          render json: { success: true }
        end
      else
        wants.html do
          build_associated_if_neccesary
          set_up_service_associations_if_neccesary
          flash.now[:error] = 'There was a problem saving, please check below for error messages.'
          edit
        end
        wants.json do
          render json: { success: false, message: @company.errors }
        end
      end
    end
  end

  def destroy
    @company.destroy

    redirect_to companies_url
  end
end
