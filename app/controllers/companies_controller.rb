class CompaniesController < ApplicationController
  respond_to :html, :json, :yaml

  load_and_authorize_resource

  attr_accessor :company, :markets, :categories

  before_filter CompaniesFilters::SetUpMarkets, CompaniesFilters::SetUpCategories, only: [:edit, :update]

  layout 'companies'

  def edit
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html {
        render(%w[listing capabilities credentials].grep(params['section']).first || 'edit')
      }
    end
  end

end
