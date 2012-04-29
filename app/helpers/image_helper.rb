module ImageHelper

  def image(name, options = {})
    options.symbolize_keys!

    source = name.is_a?(String) ? name.dup : name.to_s
    source << '.png' unless /.+\.png\Z/.match(source)
    src = options[:src] = path_to_image(source)

    i18n_data = t(".images.#{name}", raise: true) # raise error if translation data is missing

    options[:alt] = options.fetch(:alt){ i18n_data[:alt] || image_alt(src) }
    options[:title] = options.fetch(:title, i18n_data[:title])

    if size = options.delete(:size) and size =~ %r{^\d+x\d+$}
      options[:width], options[:height] = size.split("x")
    else
      options[:width], options[:height] = _size(source)
    end

    options[:id] = options.fetch(:id, name)

    tag("img", options)
  end

  private

  def _size(image)
    image = image_path_for_size(image)
    Rails.cache.fetch([:images, :image_dimensions, image]) do
      Compass::SassExtensions::Functions::ImageSize::ImageProperties.new(image).size
    end
  end

  def image_path_for_size(image_file)
    if File.exists?(image_file)
      return image_file
    end
    real_path(image_file)
  end

  def real_path(image_file)
    # Compute the real path to the image on the file stystem if the images_dir is set.
    if Compass.configuration.images_path
      File.join(Compass.configuration.images_path, image_file)
    else
      File.join(Compass.configuration.project_path, image_file)
    end
  end


end