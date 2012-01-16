class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ValidationPatterns::IPv4Address.match(value)
      record.errors[attribute] << (options[:message] || "is not a valid IPv4 address")
    end
  end
end
