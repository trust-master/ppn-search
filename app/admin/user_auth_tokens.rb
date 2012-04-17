ActiveAdmin.register UserAuthToken do
  menu false

  show do |token|
    attributes_table do
      row :user
      row :type
      row :active? do |t|
        if t.active?
          status_tag('yes', :ok)
        else
          status_tag('no')
        end
      end
      row :expires_at
      row :created_at
      row :email_sent_at
      row :fullfilled_at
      row :fullfilled_by_ip
    end

    panel 'History' do
      table_for token.versions do
        column :created_at
        column :event
        column :whodunnit
        column :controller_name
        column :ip_address
        column :changeset
      end
    end
  end

  action_item do
    link_to 'Expire Now', {action: :expire}, method: 'put'
  end
  action_item do
    link_to 'Resend Email', {action: :resend}, method: 'put'
  end

  member_action :expire, method: :put do
    resource.expire!
    redirect_to [:admin, resource.user], notice: 'Password reset was successfully expired and is no longer active.'
  end

  member_action :resend, method: :put do
    resource.mailer.deliver
    redirect_to [:admin, resource.user], notice: 'Mail was sent again.'
  end

  controller do
    actions :show
  end


end