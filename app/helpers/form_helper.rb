module FormHelper

  def fieldset(name, show_header = true, &block)
    i18n_scope = [controller.controller_name, :fieldsets]

    content_tag :fieldset, id: name, class: 'inputs' do
      html = ''.html_safe

      header       = t("#{name}.header", scope: i18n_scope, default: name.to_sym)
      what_is_this = t("#{name}.what_is_this?", scope: i18n_scope, default: '').presence
      instructions = t("#{name}.instructions", scope: i18n_scope, default: '').presence

      html << content_tag(:legend) do
        legend = ''.html_safe

        if show_header
          legend << content_tag(:h3, class: (what_is_this ? 'floated' : nil)) do
            content_tag(:span, header)
          end
        end
        if what_is_this
          legend << content_tag(:div, class: 'popup') do
            content_tag(:a, t(:what_is_this?), class: 'hint') +
            content_tag(:div, what_is_this, class: 'content')
          end
        end
        legend
      end

      if instructions
        html << content_tag(:div, instructions, class: :instructions)
      end

      html << capture(&block)

      html
    end
  end

end