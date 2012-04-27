module LayoutHelper

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

end