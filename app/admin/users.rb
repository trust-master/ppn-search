ActiveAdmin.register User do
  menu priority: 2

  filter :company
  filter :first_name
  filter :last_name
  filter :email

  index do
    selectable_column
    column :name, sortable: :last_name do |u|
      link_to u.display_name, admin_user_path(u)
    end
    column :company do |u|
      link_to u.company.name, [:admin, u.company]
    end
    column :logged_in_at
    column :active, sortable: :active do |u|
      u.active ? 'Y' : 'N'
    end
    default_actions
  end

  show title: :display_name do |c|
    attributes_table do
      row :role
      row :display_name
      row :email
      row :company
      row :active
      row :logged_in_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :role, as: :select, collection: User::ROLES
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :email
      f.input :company
      f.input :active
    end
    f.buttons
  end

  member_action :reset_password do
    user = User.find(params[:id])
    token = user.password_resets.create(created_by_ip: request.ip)
    UserMailer.password_reset(token).deliver # FIXME: Set this up in an observer

    redirect_to admin_user_path(user), notice: 'Password reset email sent to User!'
  end

  action_item only: [:show, :edit] do
    link_to(t('.reset_password'), reset_password_admin_user_path(user))
  end
end