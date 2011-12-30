class ServiceArea < ActiveRecord::Base
  belongs_to :market
  has_many :company_service_areas
  has_many :companies, :through => :company_service_areas
end

