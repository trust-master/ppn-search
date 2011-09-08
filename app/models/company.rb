class Company < ActiveRecord::Base
    belongs_to :company_category
    has_many :affiliations
    has_many :associations
    has_many :certifications
    has_many :discounts
    has_many :service_area_coverages
    has_one :business_certificate
    has_one :personal_certificate
end
