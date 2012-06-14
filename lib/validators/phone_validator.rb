class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (10...16) === value.gsub(/[^\d]+/, '').length
      record.errors.add(attribute, (options[:message] || :phone_number))
    end
  end
end