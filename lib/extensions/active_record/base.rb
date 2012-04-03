class ActiveRecord::Base

  protected

  def mass_assignment_role
    current_user_role = ::User.current_user.try(:role).try { |r| r.underscore.to_sym }
    mass_assignment_options[:as] || current_user_role || :default
  end


end