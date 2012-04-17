# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  default_options = {tag: :li, class: :input, error_class: :error}

  config.wrappers default_options do |w|
    w.use :html5
    w.use :placeholder

    w.use :label
    w.use :input
    w.use :hint, wrap_with: {tag: :span, class: :hint}
    w.use :error, wrap_with: {tag: :span, class: :error}
  end

  config.wrappers :login, default_options do |w|
    w.use :html5
    w.use :placeholder

    w.use :label
    w.use :input
  end

  config.wrappers :search, default_options.merge(tag: :div) do |w|
    w.use :html5
    w.use :placeholder

    w.use :input
  end

  config.wrappers :active_admin, default_options do |w|
    w.use :html5
    w.use :placeholder

    w.use :label
    w.use :input
    w.use :error, wrap_with: {tag: :p, class: 'inline-errors'}
    w.use :hint, wrap_with: {tag: :p, class: 'inline-hints'}
  end

  # Method used to tidy up errors.
  # config.error_method = :first

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required| "#{required} #{label}" }

  # Whether attributes are required by default (or not). Default is true.
  config.required_by_default = false

  # Tell browsers whether to use default HTML5 validations (novalidate option).
  # Default is enabled.
  config.browser_validations = true

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :mounted_as, :file?, :public_filename ]

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  config.country_priority = 'United States'

  # Default size for text inputs.
  # config.default_input_size = 50

  # When false, do not use translations for labels, hints or placeholders.
  # config.translate = true
end


