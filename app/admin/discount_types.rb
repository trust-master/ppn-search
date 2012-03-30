ActiveAdmin.register DiscountType do
  menu parent: 'Enumerables'

  before_filter { @skip_sidebar = true }

  index do
    selectable_column
    column :name do |c|
      link_to c.name, [:admin, c]
    end
    default_actions
  end

  show do |c|
    attributes_table do
      row :name
      row :sort_order
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs :name, :sort_order
    f.buttons
  end
end