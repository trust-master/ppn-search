class SearchController < InheritedResources::Base
  respond_to :html, :json

  defaults resource_class: Company, collection_name: 'companies'
  actions :index

  authorize_resource :company_search

  def index
    @search = Company.metasearch(params[:search]) # this is used by the search form builder

    index! do |format|
      format.html do
        if collection
          render :search
        else
          render :index
        end
      end
    end
  end

  protected

    def collection
      if params[:search]
        @companies ||= end_of_association_chain
                        .accessible_by(current_ability)
                        .metasearch(params[:search]).relation
                        .uniq(true)
                        .page(params[:page])
      else
        nil
      end
    end

    def popular_categories
      @popular_categories ||= SubCategory.order('companies_count DESC').limit(8).includes(:category)
    end
    helper_method :popular_categories


end