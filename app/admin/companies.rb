ActiveAdmin.register Company do
  menu priority: 1

  filter :name

  batch_action :fetch_license_data do |ids|
    fetchables =  BusinessLicense.where(company_id: ids)
    fetchables += PersonalLicense.where(company_id: ids)
    fetchables += BusinessFiling.where(company_id: ids)
    fetchables.each {|f| f.fetch }

    redirect_to admin_companies_path
  end

  index do |i|
    selectable_column
    column :name, sortable: :name do |c|
      link_to c.name, [:admin, c]
    end
    column :primary_location_name
    column :active
    column :visible
    default_actions

  end
  sidebar :notice, only: :index do
    "This search is not complete! It doesn't match the full-text behavior of the search on the main application. Stay tuned!"
  end

  show title: :name do |c|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item only: [:edit, :show] do
    link_to(t('.view_in_app'), company_path(company)) if company.active && company.visible
  end

  form partial: 'form'

  controller do
    load_resource except: :index
    attr_accessor :company, :markets, :categories
    before_filter ::CompaniesFilters::SetUpMarkets, ::CompaniesFilters::SetUpCategories, only: %w[new edit]

    def scoped_collection
      scope = end_of_association_chain.accessible_by(current_ability)
      scope = CompanySearch.new(params[:name], params[:sub_category], scope)
      # scope = scope.includes(locations: [{state: :country}, :country]) if scope.any?

      return scope
    end
  end
end

