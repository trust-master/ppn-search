class Company < ActiveRecord::Base
    belongs_to :company_category
    has_many :affiliations
    has_many :associations
    has_many :certifications
    has_many :service_area_coverages
end
