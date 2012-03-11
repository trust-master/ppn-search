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

  private

  def build_action_link(type, *args)
    options = args.extract_options! || {}
    lookup_for_text = args.first
    lookups = []
    if lookup_for_text
      lookups << :".actions.#{lookup_for_text}.#{type}"
      lookups << :".actions.#{lookup_for_text}_#{type}"
      lookups << :".actions.#{lookup_for_text}"
      lookups << :"actions.#{lookup_for_text}.#{type}"
      lookups << :"actions.#{lookup_for_text}_#{type}"
      lookups << :"actions.#{lookup_for_text}"
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
    text = results.last.is_a?(I18n::MissingTranslation) ? results.first.html_message : results.last

    content_tag :a, {class: type}.merge(options) do
      content_tag(:div, '', class: :icon) + text.html_safe
    end
  end

end