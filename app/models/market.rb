class Market < ActiveRecord::Base
  has_many :discounts
  has_many :service_areas
  has_many :company_service_areas, :through => :service_areas
  has_many :companies, :through => :company_service_areas
end
