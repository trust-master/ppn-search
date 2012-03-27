module CompanyDecorator # < ApplicationDecorator
  def in_business_since
    read_attribute(:in_business_since).year
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