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

      company.has_many :company_categories,    include: { sub_category: :category }
      company.has_many :company_service_areas, include: { service_area: :market }

      company.has_many :business_licenses, include: :issuing_state
      company.has_many :personal_licenses, include: :issuing_state
      # this should be has_one, but, due to quirks, it's not (see below)
      company.has_many :business_filings,  include: :issuing_state, limit: 1, order: 'updated_at'
    end

    with_options uniq: true, readonly: true do |company|
      company.has_many :sub_categories, through: :company_categories
      company.has_many :categories,     through: :sub_categories

      company.has_many :service_areas,  through: :company_service_areas, include: :market
      company.has_many :markets,        through: :service_areas,         include: :service_areas
    end

    has_many :users, dependent: :destroy

    belongs_to :insurance_state, class_name: 'State'

    belongs_to :deleted_by_user, class_name: 'User'

  ### Nested Attributes

    accepts_nested_attributes_for :affiliations, :associations, :certifications,
      allow_destroy: true,
      reject_if: proc { |attributes|
        attributes.values_at(:name, :title).all?(&:blank?)
      }

    accepts_nested_attributes_for :locations,
      allow_destroy: true,
      reject_if: proc { |attributes|
        attributes.values_at(:city, :zip).all?(&:blank?)
      }

    accepts_nested_attributes_for :business_licenses, :personal_licenses, :business_filings,
      allow_destroy: true,
      reject_if: proc { |attributes|
        attributes.has_key?(:id) or attributes.values_at(:number, :issuing_state_id).all?(&:blank?)
      }

    accepts_nested_attributes_for :company_service_areas, :company_categories,
      allow_destroy: true

  ### Uploaders
    has_attached_file :insurance_certificate

  ### Attribute Normalizers
    normalize_attributes :phone_main, :phone_mobile, :phone_fax, with: :phone_number
    normalize_attributes :website_url, :about, :benefits, :description, :specialty

  ### Callbacks
    before_validation :nullify_insurance_fields_if_necessary
    set_callback(:post_process, :before) do
      !! ValidationPatterns::ImageContentTypes.match(insurance_certificate.content_type)
    end

  ### Validations
    with_options if: :insured do |user|
      user.validates :insurance_state,       presence: true
      user.validates :insurance_valid_from,  presence: true, date: { in_past: true }
      user.validates :insurance_valid_until, presence: true, date: { in_future: true }
      user.validates_attachment :insurance_certificate,
        size: {
          less_than_or_equal_to: 1.megabytes,
          allow_blank: true },
        content_type: {
          content_type: ValidationPatterns::AcceptableUploadTypes,
          allow_blank: true }
    end
    validates :name, :email, :phone_main, :phone_mobile, :phone_fax, :website_url, :about,
      length: { maximum: 255 }, allow_blank: true
    validates :name, uniqueness: true, presence: true
    validates :phone_fax, :phone_main, :phone_mobile, phone: true, allow_blank: true
    validates :email, email: true, allow_blank: true
    validates :in_business_since, date: { in_past: true }, allow_blank: true
    validates :website_url, url: true, allow_blank: true

  ### Attribute Protection
    attr_accessible :name, :email, :phone_main, :phone_mobile, :phone_fax, :website_url,
      :in_business_since, :about, :description, :specialty, :offers_24_hour_service,
      :offers_emergency_service, :insured, :insurance_state_id, :insurance_certificate,
      :insurance_valid_from, :insurance_valid_until, :benefits, as: [:user, :company_admin, :administrator]
    attr_accessible :affiliations_attributes, :associations_attributes, :certifications_attributes,
      :locations_attributes, :business_licenses_attributes, :personal_licenses_attributes,
      :business_filings_attributes, :company_service_areas_attributes,
      :company_categories_attributes, :discounts_attributes, as: [:user, :company_admin, :administrator]

    attr_accessible :visible, as: :administrator

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

    def about
      raise "The About column is not being used, but #about was just called!"
    end
    def about?
      raise "The About column is not being used, but #about? was just called!"
    end
    def about=(value)
      raise "The About column is not being used, but #about= was just called!"
    end

  ### Class Methods
  # class << self; end

  private

    # the form simply hides the insurance fields when the user says "No". this will actually nullify
    # the respective collumns unless #insured is truthy
    def nullify_insurance_fields_if_necessary
      return if self[:insured]
      self[:insurance_state_id]    = nil
      self[:insurance_certificate] = nil
      self[:insurance_valid_from]  = nil
      self[:insurance_valid_until] = nil
    end
end




