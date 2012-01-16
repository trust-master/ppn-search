# Validates what is a valid email address at what could be a public domain name or IP address
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ValidationPatterns::EmailAddress.match(value)
      record.errors[attribute] << (options[:message] || "is not a valid email address")
    end
  end
end