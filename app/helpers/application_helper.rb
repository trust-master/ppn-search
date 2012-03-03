module ApplicationHelper
  def view_identifier # DISQUS relies on this string... don't change it!
    [controller.controller_name, controller.action_name].join('#')
  end

  def dev_note(note = nil)
    source = caller.grep(%r[app/views/.*\.haml:\d+]).first.gsub(%r[^.*app/views/(.*.haml:\d+):in .*$], '\1')

    content_tag :div, class: :dev_note do
      content_tag :div, class: :note do
        output = content_tag(:div, class: :body) { note || yield }
        output << content_tag(:div, class: :source) { source }
        output
      end
    end
  end

  def hidden_if(boolean)
    { style: boolean ? 'display: none;' : nil }
  end

end
