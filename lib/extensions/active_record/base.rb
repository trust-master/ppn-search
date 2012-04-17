module ActiveRecord
  class Base


    protected

    def mass_assignment_role
      mass_assignment_options[:as] || begin
        current_user_role = ::User.current_user.try(:role).try { |r| r.underscore.to_sym }
        current_user_role || :default
      end
    end

  end
end