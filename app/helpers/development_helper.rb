module DevelopmentHelper
  # Returns the familiar "Controller#action" string, to tie DISQUS threads to a given
  # controller/action pair. DISQUS threads rely on this string... don't change it!
  def disqus_identifier
    [controller.controller_name, controller.action_name].join('#')
  end

  # Inserts a development note to the page. See styling in development.sass. It's a great way to
  # communicate back to the Trust Master folks, with context. Kind of like a PostIt on the page...
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
end