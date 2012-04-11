class ActiveRecord::Base

  # def sanitize_for_mass_assignment_with_logger(attributes, role = :default)
  #   logger.debug "#{self.class}#sanitize_for_mass_assignment(#{attributes.inspect}, #{role.inspect})"
  #   sanitize_for_mass_assignment_without_logger(attributes, role)
  # end
  # alias_method_chain :sanitize_for_mass_assignment, :logger

  protected

  def mass_assignment_role
    mass_assignment_options[:as] || begin
      current_user_role = ::User.current_user.try(:role).try { |r| r.underscore.to_sym }
      current_user_role || :default
    end
  end


end