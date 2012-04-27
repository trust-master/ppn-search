module UserHelper

  def values_for_role_input
    roles = current_user.is_a?(Administrator) ? User::PROTECTED_ROLES : User::ROLES
    roles.map { |role| [role.constantize.model_name.human, role]}
  end

  def values_for_active_input
    values = [true, false]
    values.map do |value|
      [lookup_enumerized_value(:active, value), value]
    end
  end

  def lookup_enumerized_value(attr_name, value)
    lookups = []
    lookups << [:enumerize, User.model_name.i18n_key, attr_name, value].join('.').to_sym
    lookups << [:enumerize, attr_name, value].join('.').to_sym
    I18n.t(lookups.shift, default: lookups)
  end

end