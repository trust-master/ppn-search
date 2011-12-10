# == Schema Information
#
# Table name: companies
#
#  id                       :integer         not null, primary key
#  active                   :boolean         default(FALSE)
#  visible                  :boolean         default(FALSE)
#  deleted_at               :datetime
#  deleted_by_user_id       :integer
#  admin_email              :string(255)
#  name                     :string(255)
#  email                    :string(255)
#  phone_main               :string(255)
#  phone_mobile             :string(255)
#  phone_fax                :string(255)
#  website_url              :string(255)
#  in_business_since        :date
#  about                    :string(255)
#  description              :text
#  general_info             :text
#  offers_24_hour_service   :boolean         default(FALSE)
#  offers_emergency_service :boolean         default(FALSE)
#  insured                  :boolean         default(FALSE)
#  insurance_state_id       :integer
#  insurance_certificate    :string(255)
#  insurance_valid_from     :date
#  insurance_valid_until    :date
#  created_at               :datetime
#  updated_at               :datetime
#

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
