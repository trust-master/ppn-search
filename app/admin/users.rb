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
  scope :inactive do |scope|
    scope.where(active: false)
  end

  USER_ROLES = User::PROTECTED_ROLES.map do |role|
    [I18n.t(role.underscore, scope: 'admin.users.role'), role]
  end
  USER_ROLES.each do |name, role|
    self.send(:scope, name) do |scope|
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
      row(:role) { I18n.t(c.role.underscore, scope: 'admin.users.role') }
      row :display_name
      row :email
      row :phone
      row :company
      row :active
      row :logged_in_at
      row :created_at
      row :updated_at
    end
    panel "Activation Tokens (password resets & email changes)" do
      table_for c.auth_tokens do
        column :type do |t|
          t.class.model_name.human
        end
        column :expires_at
        column :fullfilled_at
        column :created_at
        column :active? do |t|
          if t.active?
            status_tag('yes', :ok)
          else
            status_tag('no')
          end
        end
        column '' do |token|
          links = ''.html_safe
          links += link_to 'Details', admin_user_auth_token_path(id: token.id), class: "member_link"
          if token.active?
            links += link_to 'Expire Now', expire_admin_user_auth_token_path(id: token.id), method: 'put', class: "member_link"
            links += link_to 'Resend Email', resend_admin_user_auth_token_path(id: token.id), method: 'put', class: "member_link"
          end
          links
        end
      end
    end

    panel 'History' do
      table_for resource.versions do
        column :created_at
        column :event
        column :whodunnit
        column :controller_name
        column :ip_address
        column :changeset
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :role, as: :select, collection: USER_ROLES
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :company, hint: 'This is required only when user is a Company Admin'
      # f.input :active
    end
    f.buttons
  end

  member_action :reset_password do
    user = User.find(params[:id]).reset_password!

    redirect_to admin_user_path(user), notice: 'Password reset email sent to User!'
  end

  action_item only: [:edit, :show] do
    link_to t('.view_in_app'), edit_company_user_path(user.company, user) if user.company
  end

  action_item only: [:show, :edit] do
    link_to t('.reset_password'), reset_password_admin_user_path(user)
  end
end