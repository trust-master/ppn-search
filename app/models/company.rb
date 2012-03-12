class Company < ActiveRecord::Base
  attr_accessor :current_sections

  ### Associations

    with_options dependent: :destroy do |company|
      has_many :affiliations
      has_many :associations
      has_many :certifications

      has_many :discounts

      has_many :locations, dependent: :destroy

      has_many :company_categories,    include: {:sub_category => :category}
      has_many :company_service_areas, include: {:service_area => :market}
    end

    with_options uniq: true, readonly: true do |company|
      has_many :sub_categories, through: :company_cateories
      has_many :categories,     through: :sub_categories

      has_many :service_areas,  through: :company_service_areas
      has_many :markets,        through: :service_areas
    end

    with_options dependent: :nullify do |company|
      company.has_many :business_licenses
      company.has_many :personal_licenses
      # this should be has_one, but, due to quirks, it's not (see below)
      company.has_many :business_filings, limit: 1, order: 'updated_at'
    end

    has_many :users

    belongs_to :insurance_state, class_name: 'State'

    belongs_to :deleted_by_user, class_name: 'User'

  ### Nested Attributes

    accepts_nested_attributes_for :affiliations, :associations, :certifications, allow_destroy: true,
      reject_if: proc { |attributes| attributes.values_at(:name, :title).all?(&:blank?) }

    accepts_nested_attributes_for :locations, allow_destroy: true,
      reject_if: proc { |attributes| attributes.values_at(:city, :zip).all?(&:blank?) }

    accepts_nested_attributes_for :business_licenses, :personal_licenses, :business_filings, allow_destroy: true,
      reject_if: proc { |attributes|
        attributes.has_key?(:id) or attributes.values_at(:number, :issuing_state_id).all?(&:blank?)
      }

    accepts_nested_attributes_for :company_service_areas, :company_categories, allow_destroy: true

  ### Attribute Protection
    attr_accessible :admin_email, :name, :email, :phone_main, :phone_mobile, :phone_fax, :website_url,
      :in_business_since, :about, :description, :general_info, :offers_24_hour_service,
      :offers_emergency_service, :insured, :insurance_state_id, :insurance_certificate,
      :insurance_valid_from, :insurance_valid_until

    # also make sure all the nested attributes are accessible
    attr_accessible :affiliations_attributes, :associations_attributes, :certifications_attributes,
      :locations_attributes, :business_licenses_attributes, :personal_licenses_attributes,
      :business_filings_attributes, :company_service_areas_attributes, :company_categories_attributes

  ### Callbacks
    before_validation :nullify_insurance_fields_if_necessary

  ### Validations
      # validates :active
      # validates :admin_email, email: true
      # validates :deleted_at
      # validates :deleted_by_user_id
      # validates :description
      # validates :general_info
      # validates :insurance_certificate
      # validates :insurance_state_id
      # validates :insurance_valid_from
      # validates :insurance_valid_until
      # validates :insured
      # validates :offers_24_hour_service
      # validates :offers_emergency_service
      # validates :phone_fax
      # validates :phone_main
      # validates :phone_mobile
      # validates :visible
    validates :about, length: { maximum: 255 }, allow_blank: true
    validates :email, email: true, allow_blank: true
    validates :in_business_since, date: { in_past: true }, allow_blank: true
    validates :name, presence: true
    validates :website_url, url: true, allow_blank: true

  ### Uploaders
    # mount the certificate carrierwave uploader on the insurance_certificate column
    mount_uploader :insurance_certificate, CertificateUploader

  ### Instance Methods
    # Show the company name in the URL
    def to_param
      [id, read_attribute(:name).parameterize].join('-')
    end

    # since I was having trouble bending the has_one to my will (specifically, allowing for only
    # delete/create/replace operations on it), I opted to use (has_many, limit: 1), so this will
    # return that one record (or nil), using the singular name.
    def business_filing
      business_filings.first
    end

  ### Class Methods
  class << self; end

  private

    # the form simply hides the insurance fields when the user says "No". this will actually nullify
    # the respective collumns unless #insured is truthy
    def nullify_insurance_fields_if_necessary
      return if self[:insured]
      self[:insurance_state_id] = nil
      self[:insurance_certificate] = nil
      self[:insurance_valid_from] = nil
      self[:insurance_valid_until] = nil
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

