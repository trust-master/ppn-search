class SearchController < InheritedResources::Base
  respond_to :html, :json

  defaults resource_class: Company, collection_name: 'companies'
  actions :index

  authorize_resource :company_search

  def index
    @search = Company.metasearch(params[:search])
    index! do |format|
      format.html do
        if collection
          render :search
        else
          @popular_categories = Rails.cache.fetch(:popular_categories){
            CompanyCategory
              .select(['count(*) as total', :sub_category_id])
              .includes(:sub_category)
              .group(:sub_category_id)
              .order('total DESC')
              .limit(5)
              .uniq
              .map { |cc|
                [cc.total.to_i, cc.sub_category]
              }
          }
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


end