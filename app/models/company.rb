class Company < ActiveRecord::Base
  has_many :company_categories
  has_many :sub_categories, :through => :company_categories
  has_many :categories, :through => :sub_categories

  has_many :affiliations
  has_many :associations
  has_many :certifications

  has_many :discounts

  # These ones are also possible, but don't make sense, to me, at present:
  # has_many :markets, :through => :discounts
  # has_many :discount_types, :through => :discounts

  has_many :company_service_areas
  has_many :service_areas, :through => :company_service_areas
  has_many :markets, :through => :service_areas

  has_many :locations

  has_one :business_license
  has_one :personal_license
  has_one :business_filing

  has_many :users
  has_many :admins

  belongs_to :insurance_state, :class_name => 'State'

  accepts_nested_attributes_for :affiliations, :associations, :certifications, :locations,
    :business_license, :personal_license, :business_filing

  attr_accessible :admin_email, :name, :email, :phone_main, :phone_mobile, :phone_fax, :website_url,
    :in_business_since, :about, :description, :general_info, :offers_24_hour_service,
    :offers_emergency_service, :insured, :insurance_state_id, :insurance_certificate,
    :insurance_valid_from, :insurance_valid_until
  # also make sure all the nested attributes are accessible
  attr_accessible :affiliations_attributes, :associations_attributes, :certifications_attributes,
    :locations_attributes, :business_license_attributes, :personal_license_attributes,
    :business_filing_attributes

  def to_param
    [id, name.parameterize].join('-')
  end

end

