ActiveAdmin.register User do
  menu priority: 2

  filter :company, collection: proc { Company.order(:name).all }
  filter :first_name_or_last_name, as: :string, label: 'Name'
  filter :email
  filter :logged_in_at

  scope :all, default: true
  scope :active do |scope|
    scope.where(active: true)
  end
  User::ROLES.each do |role|
    self.send(:scope, role) do |scope|
      scope.where(role: role)
    end
  end

  index do
    selectable_column
    column :name, sortable: :name do |u|
      link_to u.display_name, admin_user_path(u)
    end
    column :company, sortable: :companies_name do |u|
      link_to u.company_name, [:admin, u.company] if u.company.present?
    end
    column :logged_in_at
    column :active, sortable: :active do |u|
      if u.active
        status_tag('active', :ok)
      else
        status_tag('inactive')
      end
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