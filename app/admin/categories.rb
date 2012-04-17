ActiveAdmin.register Category do
  menu priority: 3

  filter :name
  filter :sub_categories_name, as: :string

  index do
    selectable_column
    column :name do |c|
      link_to c.name, [:admin, c]
    end
    column :sub_categories do |c|
      c.sub_categories.map{|s| s.name}.join(', ')
    end
    default_actions
  end

  show do |c|
    attributes_table do
      row :name
      row :sub_categories do
        ul do
          c.sub_categories.map do |s|
            li s.name
          end
        end
      end
      row :sort_order
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs :name, :sort_order
    f.has_many :sub_categories do |s|
      s.input :name
      s.input :sort_order
    end
    f.buttons
  end
end
