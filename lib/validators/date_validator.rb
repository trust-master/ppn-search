class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, date)
    if date.is_a? Date
      if options[:in_past] and !date.past?
        record.errors.add(attribute, (options[:message] || :in_past))
      end
      if options[:in_future] and !date.future?
        record.errors.add(attribute, (options[:message] || :in_future))
      end
    elsif date.present?
      record.errors.add(attribute, (options[:message] || :date))
    end
  end
end