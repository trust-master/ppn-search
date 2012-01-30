# Validates password complexity requirements
class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.length >= 6 and value.match(/[0-9]/) and value.match(/\W/)
      record.errors[attribute] << (options[:message] || I18n.t('user.password_complexity.error'))
    end
  end
end