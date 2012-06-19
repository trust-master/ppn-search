module ProfileHelper

  def profile_section(name, opts={}, &block)
    i18n_scope = [:section, name].join('.')

    content_tag :section, class: name do
      html = ''.html_safe

      header       = t(".#{i18n_scope}.header", default: '').presence
      what_is_this = t(".#{i18n_scope}.what_is_this?", default: '').presence
      instructions = t(".#{i18n_scope}.instructions", default: '').presence

      html << content_tag(:header) do
        String.new.html_safe.tap do |h|
          if header
            h << content_tag(:h3, class: (what_is_this ? 'floated' : nil)) do
              content_tag(:span, header)
            end
          end
          if what_is_this
            h << content_tag(:div, class: 'what_is_this popup') do
              content_tag(:a, t(:what_is_this?), class: 'hint') +
              content_tag(:div, format_as_markdown(what_is_this), class: 'content')
            end
            h << content_tag(:div, '', class: :clear)
          end
        end
      end

      if instructions and !opts[:skip_instructions]
        html << content_tag(:div, instructions, class: :instructions)
      end

      html << capture(&block)

      html
    end
  end

end