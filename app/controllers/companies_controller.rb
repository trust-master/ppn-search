class CompaniesController < InheritedResources::Base
  respond_to :html, :json, :yaml
  load_and_authorize_resource

  attr_accessor :company, :markets, :categories

  before_filter CompaniesFilters::SetUpMarkets, CompaniesFilters::SetUpCategories, only: %w[new edit]

  layout 'companies'

  def index
    @companies = CompanySearch.new(params[:name], params[:sub_category], @companies)
    @companies = @companies.page(params[:page]).per(5)

    respond_with @companies do |wants|
      wants.html { render :index, layout: 'application'}
      wants.json
    end
  end

  # def show
  #   respond_with @company
  # end

  # def new
  #   respond_with @company
  # end

  # def create
  #   respond_with @company do |wants|
  #     if @company.save
  #       wants.html do
  #         flash[:notice] = 'Company created successfully.'
  #         redirect_to @company
  #       end
  #     else
  #       wants.html do
  #         flash.now[:error] = 'There was a problem saving, please check below for error messages.'
  #         new
  #       end
  #     end
  #   end
  # end

  def edit
    respond_with @company do |wants|
      wants.html do
        render(params[:section] || :edit)
      end
    end
  end

  # def update
  #   respond_with @company do |wants|
  #     if @company.update_attributes(params[:company])
  #       wants.html do
  #         flash[:notice] = 'Company saved successfully.'
  #         redirect_to @company
  #       end
  #     else
  #       wants.html do
  #         flash.now[:error] = 'There was a problem saving, please check below for error messages.'
  #         edit
  #       end
  #     end
  #   end
  # end

  # def destroy
  #   @company.destroy

  #   redirect_to companies_url
  # end
end
