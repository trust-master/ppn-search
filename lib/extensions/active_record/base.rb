module ActiveRecord
  class Base

    def self.mailer
      lookup_ancestors.each do |klass|
        mailer = klass.model_name.mailer_name.safe_constantize and return mailer
      end
      return nil
    end

    protected

    def mass_assignment_role
      mass_assignment_options[:as] || ::User.current_user.try(:role).try { |r| r.underscore.to_sym } || :default
    end

  end
end