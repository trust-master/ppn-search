class Company < ActiveRecord::Base
  attr_accessor :current_sections
  paginates_per 5

  ### Associations

    with_options dependent: :destroy do |company|
      company.has_many :affiliations
      company.has_many :associations
      company.has_many :certifications

      company.has_many :discounts,             include: :type

      company.has_many :locations,             include: [:state, :country]

      company.has_many :company_categories,    include: {sub_category: :category}
      company.has_many :company_service_areas, include: {service_area: :market}
    end

    with_options uniq: true, readonly: true do |company|
      company.has_many :sub_categories, through: :company_categories
      company.has_many :categories,     through: :sub_categories

      company.has_many :service_areas,  through: :company_service_areas, include: :market
      company.has_many :markets,        through: :service_areas, include: :service_areas
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

    accepts_nested_attributes_for :discounts, allow_destroy: true

  ### Attribute Protection

    attr_accessible :name, :email, :phone_main, :phone_mobile, :phone_fax,
      :website_url, :in_business_since, :about, :description, :general_info,
      :offers_24_hour_service, :offers_emergency_service, :insured, :insurance_state_id,
      :insurance_certificate, :insurance_certificate_cache, :remove_insurance_certificate,
      :insurance_valid_from, :insurance_valid_until, as: [:user, :company_admin, :administrator]

    # also make sure all the nested attributes are accessible
    attr_accessible :affiliations_attributes, :associations_attributes, :certifications_attributes,
      :locations_attributes, :business_licenses_attributes, :personal_licenses_attributes,
      :business_filings_attributes, :company_service_areas_attributes,
      :company_categories_attributes, :discounts_attributes, as: [:user, :company_admin, :administrator]

    attr_accessible :active, :visible, as: :administrator

  ### Callbacks
    before_validation :nullify_insurance_fields_if_necessary

  ### Validations
    with_options if: :insured do |user|
      user.validates :insurance_certificate, presence: true
      user.validates :insurance_state, presence: true, associated: true
      user.validates :insurance_valid_from, presence: true, date: { in_past: true }
      user.validates :insurance_valid_until, presence: true, date: { in_future: true }
    end
    # validates :phone_fax, :phone_main, :phone_mobile, phone: true
    validates :about, length: { maximum: 255 }, allow_blank: true
    validates :email, email: true, allow_blank: true
    validates :in_business_since, date: { in_past: true }, allow_blank: true
    validates :name, presence: true
    validates :website_url, url: true, allow_blank: true

  ### Uploaders
    # mount the certificate carrierwave uploader on the insurance_certificate column
    mount_uploader :insurance_certificate, CertificateUploader

  ### Scopes
    # default_scope includes(:locations, :company_categories, :company_service_areas)
    scope :any_text_field_contains, lambda { |query|
      ids = CompanySearch.search(query).pluck(:company_id)
      where(id: ids.uniq)
    }
    search_methods :any_text_field_contains

  ### Instance Methods
    delegate :name, to: :insurance_state, prefix: true

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

    def primary_location_name
      locations.first.try(:name)
    end

    def in_business_since=(string)
      date = Date.new(string.to_i)
      write_attribute(:in_business_since, date)
    end

    def phone_numbers
      @phone_numbers or begin
        numbers = {}
        numbers[:phone_main]   = phone_main   if phone_main?
        numbers[:phone_mobile] = phone_mobile if phone_mobile?
        numbers[:phone_fax]    = phone_fax    if phone_fax
        @phone_numbers = numbers
      end
    end

    def all_licenses
      self.business_licenses + self.personal_licenses + self.business_filings
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
#  active                   :boolean         default(FALSE), not null
#  visible                  :boolean         default(FALSE), not null
#  deleted_at               :datetime
#  deleted_by_user_id       :integer
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
#  offers_24_hour_service   :boolean         default(FALSE), not null
#  offers_emergency_service :boolean         default(FALSE), not null
#  insured                  :boolean         default(FALSE), not null
#  insurance_state_id       :integer
#  insurance_certificate    :string(255)
#  insurance_valid_from     :date
#  insurance_valid_until    :date
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#

