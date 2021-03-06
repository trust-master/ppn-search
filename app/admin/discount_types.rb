ActiveAdmin.register DiscountType do
  menu label: 'Offers', priority: 4

  before_filter { @skip_sidebar = true }

  index do
    selectable_column
    column :name do |c|
      link_to c.name, [:admin, c]
    end
    actions
  end

  show do |type|
    attributes_table do
      row :name
      row :sort_order
      row :created_at
      row :updated_at
    end
    panel "Service Providers with Offers of this Type" do
      table_for type.companies do
        column :name
        column :discounts do |c|
          c.discounts.map(&:title).join(', ')
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs :name, :sort_order
    f.actions
  end
end
