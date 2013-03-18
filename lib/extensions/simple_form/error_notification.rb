module SimpleForm
  class ErrorNotification
    delegate :object, :object_name, :template, :to => :@builder

    def initialize(builder, options)
      @builder = builder
      @message = options.delete(:message)
      @options = options
    end

    def render
      if has_errors?
        template.fieldset :errors, show_header: false do
          ActiveSupport::SafeBuffer.new.tap do |output|
            output << template.content_tag(error_notification_tag, error_message, class: :message)

            output << template.content_tag(:ul, class: :fields_with_errors) do
              ActiveSupport::SafeBuffer.new.tap do |ul|

                errors.messages.each do |attribute, msg|
                  ul << template.content_tag(:li, object.class.human_attribute_name(attribute))
                end

              end
            end
          end
        end
      end
    end

    protected

    def errors
      object.errors
    end

    def has_errors?
      object && object.respond_to?(:errors) && errors.present?
    end

    def error_message
      (@message || translate_error_notification).html_safe
    end

    def error_notification_tag
      SimpleForm.error_notification_tag
    end

    def translate_error_notification
      lookups = []
      lookups << :"#{object_name}"
      lookups << :default_message
      lookups << "Some errors were found, please take a look:"
      I18n.t(lookups.shift, :scope => :"simple_form.error_notification", :default => lookups)
    end
  end
end
