class User::RoleValidator < ActiveModel::Validator
  # def setup(klass)
  # end

  def validate(record)
    role = record.send(:read_attribute_for_validation, :role)

    record.errors.add(:role, :blank) if record.role.blank?

    if record.role_changed?
      record.errors.add(:role, :user_role) unless check_role(record.role)
    end
  end

  def check_role(role)
    if User.current_user.is_a?(Administrator)
      User::PROTECTED_ROLES.include?(role)
    else
      User::ROLES.include?(role)
    end
  end
end