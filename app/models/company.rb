class Company < ActiveRecord::Base
  has_many :company_categories
  has_many :sub_categories, :through => :company_categories
  has_many :categories, :through => :sub_categories

  has_many :affiliations
  has_many :associations
  has_many :certifications

  has_many :discounts
  # has_many :markets, :through => :discounts # This one is also possible, but doesn't make sense, to me, at present
  # has_many :discount_types, :through => :discounts # This one is also possible, but doesn't make sense, to me, at present

  has_many :company_service_areas
  has_many :service_areas, :through => :company_service_areas
  has_many :markets, :through => :service_areas

  has_many :locations

  has_one :business_certificate
  has_one :personal_certificate
  has_one :business_filing

  belongs_to :insurance_state, :class_name => State
end
