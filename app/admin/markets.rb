ActiveAdmin.register Market do
  menu parent: 'Enumerables'

  before_filter { @skip_sidebar = true }

  index as: :grid, columns: 4 do |m|
    h3 link_to(m.name, [:admin, m])
    resource_selection_cell(m)
    ul do
      m.service_areas.map do |s|
        li s.name
      end
    end
  end

  show do |c|
    attributes_table do
      row :name
      row :service_areas do
        ul do
          c.service_areas.map do |s|
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
    f.has_many :service_areas do |s|
      s.input :name
      s.input :sort_order
    end
    f.buttons
  end
end
