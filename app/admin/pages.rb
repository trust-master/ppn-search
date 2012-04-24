ActiveAdmin.register Page do
  menu priority: 5
  filter :content

  index do
    selectable_column
    column :title do |p|
      link_to p.title, [:admin, p]
    end
    column :slug do |p|
      link_to p.slug, p.path
    end
    column :name
    default_actions
  end

  show(title: :title) do |p|
    attributes_table do
      row :name
      row :slug do
        link_to p.slug, p.path
      end
      row :title do
        h2 p.title
      end
      row :content do
        p.render_content
      end
      # row :published
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item only: [:edit, :show] do
    link_to(t('.view_in_app'), page.path)
  end

  form partial: 'form'

  controller do
    cache_sweeper :page_sweeper
  end
end
