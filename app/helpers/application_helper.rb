module ApplicationHelper

  # Set the page title, both for the <title> element and for the visible page header. Optional 2nd
  # argument can be used to hide the visible header
  def title(title, show_title = true)
    content_for(:title, title)
    @show_title = show_title
  end

  # Whether the header should be shown
  def show_title?
    !! @show_title
  end

  # Content for the title, defaults to I18n.t "#{controller}.#{action}.title"
  def page_title
    content_for(:title).presence || t([view_identifier, :title].join('.'))
  end

  def view_identifier
    [controller.controller_name, controller.action_name]
  end

  def hidden_if(boolean)
    { style: boolean ? 'display: none;' : nil }
  end

  # def link_to_google_maps_search(title, q = title, opts = {})
  #   link_to title, ['http://maps.google.com/', {q: q}.to_param].join('?'), opts
  # end
end
