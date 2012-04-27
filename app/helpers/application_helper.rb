module ApplicationHelper

  # Set the page title, both for the <title> element and for the visible page header. Optional 2nd
  # argument can be used to hide the visible header
  def title(title, show_title = true)
    content_for(:title, title)
    content_for(:page_title, title) if show_title
  end

  # Content for the title, defaults to I18n.t "#{controller}.#{action}.title"
  def page_title
    content_for(:page_title).presence || t([view_identifier, :title].join('.'))
  end

  def view_identifier
    [controller.controller_name, controller.action_name]
  end

  def hidden_if(boolean)
    { style: boolean ? 'display: none' : nil }
  end

  def url_for_google_maps_search(query)
    ['http://maps.google.com/', {q: query}.to_param].join('?')
  end

  def link_to_blank_tab(*args, &block)
    options = args.extract_options!
    options[:target] ||= '_blank'
    args << options
    link_to(*args, &block)
  end

  def time_ago_in_words(time)
    content_tag(:time, time.to_s, datetime: time.getutc.iso8601, class: 'timeago')
  end

  def tab_for(record, section_name = nil, &block)
    klass = [dom_class(record), section_name].compact.join(?_)
    klass = [klass, section_name, :tab].compact
    content_tag :div, id: tab_id_for(record, section_name), class: klass, &block
  end

  def tab_id_for(record, section_name = nil)
    [dom_id(record), section_name].compact.join(?_)
  end

  def page_path(name)
    REDIS[:cache].sadd(:page_names_to_suggest_for_creation, name)

    Page.slug_map[name]
  end
end
