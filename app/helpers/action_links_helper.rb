module ActionLinksHelper

  def include_remove_link(*args)
    build_action_link(:remove, *args)
  end

  def include_add_link(*args)
    build_action_link(:add, *args)
  end

  def include_expand_link(*args)
    build_action_link(:expand, *args)
  end

  def include_collapse_link(*args)
    build_action_link(:collapse, *args)
  end

  def include_edit_link(*args)
    build_action_link(:edit, *args)
  end

  def include_download_link(*args)
    build_action_link(:download, *args)
  end

  private

  def build_action_link(type, *args)
    options = args.extract_options! || {}

    scope = args.first.is_a?(Symbol) ? args.delete_at(0) : nil
    text = lookup(type, scope)


    if url_options = options.delete(:url) || args.first
      if type == :remove
        options[:method] ||= :delete
        options[:confirm] = lookup([type, :confirmation].join('_'), scope) unless options.has_key?(:confirm)
      end
      link_to(url_options, {class: type}.merge(options)) do
        content_tag(:div, '', class: :icon) + text.html_safe
      end
    else
      content_tag(:a, {class: type}.merge(options)) do
        content_tag(:div, '', class: :icon) + text.html_safe
      end
    end

  end

  def lookup(type, scope)
    lookups = []
    if scope
      lookups << :".actions.#{scope}.#{type}"
      lookups << :".actions.#{scope}_#{type}"
      # lookups << :".actions.#{scope}"
      lookups << :"actions.#{scope}.#{type}"
      lookups << :"actions.#{scope}_#{type}"
      # lookups << :"actions.#{scope}"
    end
    lookups << :".actions.#{type}"
    lookups << :"actions.#{type}"

    results = []
    lookups.each do |lookup|
      results << catch(:exception) do
        t(lookup, throw: true, rescue_format: :html)
      end
      break if not results.last.is_a?(I18n::MissingTranslation)
    end
    return results.last.is_a?(I18n::MissingTranslation) ? results.first.html_message : results.last
  end

end