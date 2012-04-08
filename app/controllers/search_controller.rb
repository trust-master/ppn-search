class SearchController < InheritedResources::Base
  respond_to :html, :json

  defaults resource_class: Company, collection_name: 'companies'
  actions :index

  authorize_resource :company_search

  def index
    @search = Company.metasearch(params[:search])
    index! do |format|
      format.html do
        render(collection.nil? ? :index : :search)
      end
    end
  end

  protected

  def collection
    if params[:search]
      @companies ||= end_of_association_chain
                      .accessible_by(current_ability)
                      .metasearch(params[:search])
                      .page(params[:page])
    else
      nil
    end
  end


end