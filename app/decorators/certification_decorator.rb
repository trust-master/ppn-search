module CertificationDecorator
  def display_identifier
    [self[:name], self[:title]].compact.first
  end

end