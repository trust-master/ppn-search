module ContentHelper

  def format_as_markdown(content, html_options = {}, options = {})
    Page::PARSER.render(content).html_safe
  end

end