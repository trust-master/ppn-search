ActiveAdmin.register EmailTemplate do
  menu label: 'Emails', priority: 6
  filter :body
  actions :edit, :update, :show, :index

  index do
    selectable_column
    id_column
    column :body do |t|
      t.body.truncate(50)
    end
    default_actions
  end

  show(title: :display_name) do |t|
    attributes_table do
      row :id
      row :subject
      row :body do
        pre t.body
      end
      row :preview do
        div(class: 'email_preview') { t.render_preview }
      end
      rows :cc, :bcc, :from
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form partial: 'form'

end