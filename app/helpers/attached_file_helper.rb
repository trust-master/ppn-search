module AttachedFileHelper

  def attached_file_thumbnail(object, attribute_name)
    return unless attachment = object.send(attribute_name)
    return unless attachment.styles.has_key?(:thumb) and thumb_url = attachment.url(:thumb).presence

    content_tag(:div, class: :attachment_thumbnail) do
      link_title = t(".#{attribute_name}.preview_title", default: :'attached_file.preview_title')

      if preview_url = attachment.url(:preview).presence
        link_to(preview_url, title: link_title, class: 'lightbox') do
          # TODO: Add dimensions here (use the paperclip-meta gem)
          image_tag thumb_url
        end
      else
        image_tag thumb_url
      end
    end
  end

  def attached_file_summary(object, attribute_name)
    return unless attachment = object.send(attribute_name)

    content_tag(:div, class: :attachment_summary) do
      ActiveSupport::SafeBuffer.new.tap do |content|
        if summary = t(".#{attribute_name}.summary", default: :'attached_file.summary').presence
          content << content_tag(:span, summary, class: :summary)
        end
        content << link_to(attachment.url) do
          t(".#{attribute_name}.download", default: :'attached_file.download')
        end
      end
    end
  end
end