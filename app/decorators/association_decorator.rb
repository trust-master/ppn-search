module AssociationDecorator
  def display_identifier
    [self[:name], self[:title]].compact.first
  end

  def url
    if url = URI(read_attribute(:url))
      link_to url.host, url.to_s
    end
  end
end