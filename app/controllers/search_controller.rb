class SearchController < ApplicationController
  respond_to :html, :json

  # defaults resource_class: Company, collection_name: 'companies'
  # actions :index

  authorize_resource :company_search

  def index
    @search = SearchQuery.new(params.fetch(:search_query, {}))

    respond_to do |format|
      format.html do
        if params.key?(:search_query)
          render :search
        else
          render :index
        end
      end
    end
  end

  protected

    def collection
      @companies ||= @search.companies.accessible_by(current_ability).uniq(true).page(params[:page])
    end
    helper_method :collection

    def popular_categories
      @popular_categories ||= SubCategory.order('companies_count DESC').limit(8).includes(:category)
    end
    helper_method :popular_categories
end
