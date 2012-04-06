module CompanyDecorator # < ApplicationDecorator

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
    address = [l.street, l.street2, l.city, l.state_abbreviation].map(&:presence).compact.join(', ')
    address << ' ' << l.zip if l.zip.present?
  end
end