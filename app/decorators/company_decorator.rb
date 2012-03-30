module CompanyDecorator # < ApplicationDecorator
  def active
    read_attribute(:active) ? 'Y' : 'N'
  end
  def visible
    read_attribute(:visible) ? 'Y' : 'N'
  end

  def since
    read_attribute(:in_business_since).try(:year)
  end

  def website
    if url = URI(read_attribute(:website_url))
      link_to url.host, url.to_s
    end
  end

  def primary_address
    l = locations.first
    [l.city, l.state_name].join(', ')
  end
end