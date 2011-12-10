# == Schema Information
#
# Table name: companies
#
#  id                                :integer         not null, primary key
#  name                              :string(255)
#  in_business_since                 :date
#  email_address                     :string(255)
#  main_phone_number                 :string(255)
#  mobile_phone_number               :string(255)
#  fax_number                        :string(255)
#  web_site                          :string(255)
#  address_1                         :string(255)
#  address_2                         :string(255)
#  city                              :string(255)
#  state                             :string(255)
#  zip_code                          :string(255)
#  about                             :string(255)
#  description                       :string(255)
#  general_info                      :string(255)
#  twenty_four_hour_service          :boolean
#  emergency_services                :boolean
#  is_insurance                      :boolean
#  insurance_expiration_month        :integer
#  insurance_expiration_year         :integer
#  personal_license_type             :string(255)
#  personal_license_number           :string(255)
#  business_certificate_type         :string(255)
#  business_certificate_number       :string(255)
#  business_status_type              :string(255)
#  filing_number                     :string(255)
#  discount_type                     :string(255)
#  discount_title                    :string(255)
#  discount_description              :string(255)
#  discount_start_date               :date
#  discount_end_date                 :date
#  is_active                         :boolean
#  created_at                        :datetime
#  updated_at                        :datetime
#  company_category_id               :integer
#  certificate_of_insurance_filename :string(255)
#

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
