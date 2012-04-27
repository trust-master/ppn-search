module LinkHelper

  def link_to_blank_tab(*args, &block)
    options = args.extract_options!
    options[:target] ||= '_blank'
    args << options
    link_to(*args, &block)
  end

  def url_for_google_maps_search(query)
    ['http://maps.google.com/', {q: query}.to_param].join('?')
  end

end