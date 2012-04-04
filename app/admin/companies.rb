ActiveAdmin.register Company do
  menu priority: 1

  filter :name

  scope :all, :default => true

  # scope :visible do |scope|
  #   scope.where(visible: true)
  # end
  # scope :active do |scope|
  #   scope.where(active: true)
  # end

  Category.includes(:company_categories).all.each do |category|
    ids = category.company_categories.map(&:company_id).uniq
    self.send(:scope, category.name) do |items|
      items.where(:id => ids)
    end
  end

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
    column :primary_location_name, sortable: false
    column :active, sortable: :active do |c|
      if c.active
        status_tag('active', :ok)
      else
        status_tag('inactive')
      end
    end
    column :visible, sortable: :visible do |c|
      if c.visible
        status_tag('visible', :ok)
      else
        status_tag('hidden')
      end
    end
    default_actions

  end
  sidebar :notice, only: :index, icon: :bolt do
    h4 "This search is not complete!"
    para "It doesn't match the full-text behavior of the search on the main application. It will soon; stay tuned!"
  end

  show title: :name do |c|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
      row :visible
      row :active

    end
    active_admin_comments
  end

  action_item only: [:edit, :show] do
    link_to(t('.view_in_app'), company_path(company)) #if company.active && company.visible
  end

  # form partial: 'form'
  form do |f|
    f.inputs do
      f.input :name
      f.input :active
      f.input :visible
    end
    f.buttons
  end
  sidebar :notice, only: :edit, icon: :info do
    h4 "This form is not complete!"
    para "It will match the behavior of the front-end eventually. For now, it exposes the main fields needed to create a new Service Provider, which can be edited in the front-end form. "
    para "Click 'View in App' above to see that form."
  end

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

