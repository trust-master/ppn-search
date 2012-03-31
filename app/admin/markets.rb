ActiveAdmin.register Market do
  menu parent: 'Enumerables'

  before_filter { @skip_sidebar = true }

  index do |t|
    t.selectable_column
    t.column :name, sortable: :name do |m|
      h3 do
        link_to m.name, [:admin, m]
      end
    end
    t.column :sort_order
    t.column :service_areas do |m|
      ul do
        m.service_areas.map do |s|
          li s.name
        end
      end
    end
    t.default_actions
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
