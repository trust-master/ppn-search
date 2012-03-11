class Company < ActiveRecord::Base
  attr_accessor :current_sections

  has_many :company_categories, dependent: :destroy,          include: {:sub_category => :category}
  has_many :sub_categories,     through: :company_categories, uniq: true, readonly: true
  has_many :categories,         through: :sub_categories,     uniq: true, readonly: true

  has_many :affiliations,   dependent: :destroy
  has_many :associations,   dependent: :destroy
  has_many :certifications, dependent: :destroy

  has_many :discounts, dependent: :destroy

  has_many :company_service_areas, dependent: :destroy,             include: {:service_area => :market}
  has_many :service_areas,         through: :company_service_areas, uniq: true, readonly: true
  has_many :markets,               through: :service_areas,         uniq: true, readonly: true

  has_many :locations, dependent: :destroy

  has_many :business_licenses, dependent: :nullify
  has_many :personal_licenses, dependent: :nullify
  has_many :business_filings,  dependent: :nullify, limit: 1, order: 'updated_at' # this should be has_one, but, due to quirks, I'll just emulate the has_one getter and let the form treat it as a collection.

  has_many :users

  belongs_to :insurance_state, class_name: 'State'

  accepts_nested_attributes_for :affiliations, :associations, :certifications, allow_destroy: true,
      reject_if: proc { |attributes| attributes.values_at(:name, :title).all?(&:blank?) }

  accepts_nested_attributes_for :locations, allow_destroy: true,
      reject_if: proc { |attributes| attributes.values_at(:city, :zip).all?(&:blank?) }

  accepts_nested_attributes_for :business_licenses, :personal_licenses, :business_filings, allow_destroy: true,
    reject_if: proc { |attributes|
      attributes.has_key?(:id) or attributes.values_at(:number, :issuing_state_id).all?(&:blank?)
    }

  accepts_nested_attributes_for :company_service_areas, :company_categories, allow_destroy: true

  attr_accessible :admin_email, :name, :email, :phone_main, :phone_mobile, :phone_fax, :website_url,
    :in_business_since, :about, :description, :general_info, :offers_24_hour_service,
    :offers_emergency_service, :insured, :insurance_state_id, :insurance_certificate,
    :insurance_valid_from, :insurance_valid_until

  # also make sure all the nested attributes are accessible
  attr_accessible :affiliations_attributes, :associations_attributes, :certifications_attributes,
    :locations_attributes, :business_licenses_attributes, :personal_licenses_attributes,
    :business_filings_attributes, :company_service_areas_attributes, :company_categories_attributes

  mount_uploader :insurance_certificate, CertificateUploader

  # Show the company name in the URL
  def to_param
    [id, read_attribute(:name).parameterize].join('-')
  end

  # since I was having trouble bending the has_one to my will (specifically, allowing for only delete/create/replace operations on it), I opted to use (has_many, limit: 1), so this will return that one record (or nil), using the singular name.
  def business_filing
    business_filings.first
  end

end


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

