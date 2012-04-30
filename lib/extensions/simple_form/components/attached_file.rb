module SimpleForm
  module Components
    module AttachedFile

      def attachment_thumbnail
        return unless input_type == :attached_file

        ActiveSupport::SafeBuffer.new.tap do |output|
          if attachment.present? and !attachment.dirty? and attachment.styles.has_key?(:thumb)
            output << template.attached_file_thumbnail(object, attribute_name)
          end
        end
      end


      def attachment_summary
        return unless [:file, :attached_file].include?(input_type)

        ActiveSupport::SafeBuffer.new.tap do |output|
          if attachment.present?
            output << template.attached_file_summary(object, attribute_name)
          end
        end
      end

      private

      # currently attached file. Not necessarily a valid image; not necessarily saved to DB.
      def attachment
        object.send(attribute_name)
      end

    end
  end
end
