class ActionView::Helpers::InstanceTag

  private

  def select_content_tag(option_tags, options, html_options)
    html_options = html_options.stringify_keys
    add_default_name_and_id(html_options)
    select = content_tag("select", add_options(option_tags, options, value(object)), html_options)
    if html_options["multiple"] and !options[:skip_hidden_field]
      tag("input", :disabled => html_options["disabled"], :name => html_options["name"], :type => "hidden", :value => "") + select
    else
      select
    end
  end

end