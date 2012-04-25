module ImageHelper

  def image(name, options = {})
    options.symbolize_keys!

    source = name.is_a?(String) ? name.dup : name.to_s
    source << '.png' unless /.+\.png\Z/.match(source)
    src = options[:src] = path_to_image(source)

    i18n_data = t(".images.#{name}", raise: true) # bang version will raise error if translation data is missing

    options[:alt] = options.fetch(:alt){ i18n_data[:alt] || image_alt(src) }
    options[:title] = options.fetch(:title, i18n_data[:title])

    if size = options.delete(:size)
      options[:width], options[:height] = size.split("x") if size =~ %r{^\d+x\d+$}
    end

    options[:id] = options.fetch(:id, name)

    tag("img", options)
  end

end