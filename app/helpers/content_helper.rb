module ContentHelper

  def format_as_markdown(content, html_options = {}, options = {})
    Page::PARSER.render(content).html_safe
  end

  def format_as_phone_number(value)
    return nil if value.blank?

    cc, number, ext = value.match(/(\d*)(\d{10})(?:x(\d+))?/).to_a[1..3]

    number_to_phone(number || value, extension: ext, country_code: cc, delimiter: ?.)
  end

end