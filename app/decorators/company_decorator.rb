module CompanyDecorator # < ApplicationDecorator
  def website_url
    link_to 'Website', self.read_attribute(:website_url) if self.read_attribute(:website_url)
  end
end