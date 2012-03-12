# Validates password complexity requirements
class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Password must have at least a number, a letter, and 6 or more chars
    unless value.length >= 6 and value.match(/[a-z]/i) and value.match(/[0-9]/)
      record.errors.add(attribute, (options[:message] || :password_complexity))
    end
  end
end