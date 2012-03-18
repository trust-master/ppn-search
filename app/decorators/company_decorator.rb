module CompanyDecorator # < ApplicationDecorator
  def website
    if url = URI(self.read_attribute(:website_url))
      link_to url.host, url.to_s
    end
  end
end