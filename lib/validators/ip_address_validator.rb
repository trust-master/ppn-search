class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ValidationPatterns::IPv4Address.match(value)
      record.errors.add(attribute, (options[:message] || :ip_address))
    end
  end
end
