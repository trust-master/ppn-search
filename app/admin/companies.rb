ActiveAdmin.register Company do
  menu priority: 1

  filter :name
  filter :active, as: :select
  filter :visible, as: :select
  filter :company_categories_sub_category_id, as: :multiple_select,
    collection:   proc { SubCategory.includes(:category).all },
    member_label: proc { |c| [c.category_name, c.name].join(' / ') }

  scope :all, default: true
  scope :active

  # Build scopes for each Category. Disabled now as there are too many categories
  # Category.includes(:company_categories).all.each do |category|
  #   ids = category.company_categories.map(&:company_id).uniq
  #   self.send(:scope, category.name) do |items|
  #     items.where(:id => ids)
  #   end
  # end

  batch_action :fetch_license_data do |ids|
    fetchables =  BusinessLicense.where(company_id: ids)
    fetchables += PersonalLicense.where(company_id: ids)
    fetchables += BusinessFiling.where(company_id: ids)
    fetchables.each {|f| f.fetch }

    redirect_to admin_companies_path
  end

  index(title: 'Provider Management') do |i|
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
    actions
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
    link_to(t('.view_in_app'), company_path(company))
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :visible
    end
    f.actions
  end

  sidebar :notice, only: :edit do
    para "Click 'View in App' above to see the full Provider profile page and edit it."
  end

  controller do
    skip_authorize_resource
    # authorize_resource Company
    # load_resource Company, except: :index
    attr_accessor :company, :markets, :categories
  end
end

