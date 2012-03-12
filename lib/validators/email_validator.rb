# Validates what is a valid email address at what could be a public domain name or IP address
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ValidationPatterns::EmailAddress.match(value)
      record.errors.add(attribute, (options[:message] || :email))
    end
  end
end