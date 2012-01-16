# Validates against what could be a publicly-accessible URL; obviously, we can't say it's for sure correct unless we request it, but it's a good start
# Not only a valid WWW URL, but one not assigned to private address spaces, and in the https?:// protocol
class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ValidationPatterns::URL.match(value)
      record.errors[attribute] << (options[:message] || "is not a valid URL (should begin with 'http[s]://')")
    end
  end
end
