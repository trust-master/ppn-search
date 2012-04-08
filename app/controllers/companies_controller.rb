class CompaniesController < InheritedResources::Base
  respond_to :html, :json, :yaml

  actions :show, :edit, :update

  load_and_authorize_resource

  attr_accessor :company, :markets, :categories

  before_filter CompaniesFilters::SetUpMarkets, CompaniesFilters::SetUpCategories, only: [:edit, :update]

  layout 'companies'

  def edit
    super do |format|
      format.html { render(params[:section] || :edit) }
    end
  end

end
