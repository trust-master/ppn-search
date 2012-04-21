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

  # def link_to_google_maps_search(title, q = title, opts = {})
  #   link_to title, ['http://maps.google.com/', {q: q}.to_param].join('?'), opts
  # end

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
    page_path_map = Rails.cache.fetch(:page_paths) { Hash[Page.select([:name, :slug]).all.map{|p| [p.name.to_sym, p.path] }] }
    return page_path_map[name.to_sym]
  end
end
