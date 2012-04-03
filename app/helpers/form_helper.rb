module FormHelper

  def fieldset(name, show_header = true, &block)
    i18n_scope = [controller.controller_name, :fieldsets]

    content_tag :fieldset, id: name do
      html = ''.html_safe

      if show_header
        html << content_tag(:legend) do
          content_tag :h3, t("#{name}.header", scope: i18n_scope, default: name.to_sym)
        end
      end

      if instructions = t("#{name}.instructions", scope: i18n_scope, default: '').presence
        html << content_tag(:div, instructions, class: :instructions)
      end

      html << capture(&block)

      html
    end
  end

end