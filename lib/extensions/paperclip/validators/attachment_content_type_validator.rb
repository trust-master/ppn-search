module Paperclip
  module Validators
    class AttachmentContentTypeValidator < ActiveModel::EachValidator

      def validate_each(record, virt_attribute, value)
        attribute = "#{virt_attribute}_content_type".to_sym
        value = record.send(:read_attribute_for_validation, attribute)
        allowed_types = [options[:content_type]].flatten

        return if (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])

        if allowed_types.none? { |type| type === value }
          record.errors.add(virt_attribute.to_sym, :invalid_format, options.merge(
            :types => [*(options[:message] || allowed_types)].to_sentence
          ))
        end
      end

    end
  end
end
