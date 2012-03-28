# RailsAdmin config file. Generated on March 13, 2012 22:07
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.current_user_method { current_user }

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Trust Master PPN Portal', 'Admin']


  config.copyright = 'Trust Master 2012'

  config.authorize_with :cancan

  config.attr_accessible_role { _current_user.role.underscore.to_sym }

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [CompanyCategory, CompanyServiceArea]

  # Add models here if you want to go 'whitelist mode': config.included_models = [Admin,
  # Affiliation, Association, BusinessFiling, BusinessLicense, BusinessLicenseType, Category,
  # Certification, Company, CompanyAdmin, CompanyCategory, CompanyServiceArea, Country, Discount,
  # DiscountType, FilingStatus, FilingType, LicenseStatus, LicenseType, Location, Market,
  # PasswordReset, PersonalLicense, PersonalLicenseType, ServiceArea, State, SubCategory, User,
  # UserAuthToken]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  config.models do
    # Configuration here will affect all included models in all scopes, handle with care!

    # list do
    #   # Configuration here will affect all included models in list sections (same for show, export,
    #   # edit, update, create)

    #   fields_of_type :date do
    #     # Configuration here will affect all date fields, in the list section, for all included
    #     # models. See README for a comprehensive type list.
    #   end
    # end

    # edit do
    #   fields do
    #     visible do
    #       # visible && !read_only # hide read-only fields form forms
    #     end
    #   end
    # end

    configure(:id) { visible false }
    configure(:created_at) { visible false }
    configure(:updated_at) { visible false }
    configure(:company_id) { visible false }
    configure(:company) { visible false }



    list do
      fields_of_type :boolean do
        formatted_value do
          value ? 'Y' : 'N'
        end
      end
    end
    show do
      fields_of_type :boolean do
        formatted_value do
          value ? 'Yes' : 'No'
        end
      end
    end
  end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  #
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels
  # for models and attributes, use ActiveRecord I18n API instead.
  #
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  config.model Company do
    weight(-99)

    [:deleted_at, :deleted_by_user].each do |col|
      configure(col) { visible false }
    end

    [:company_categories, :company_service_areas, :sub_categories, :categories, :service_areas, :markets].each do |col|
      configure(col) { visible false }
    end

    # Sections:
    list do
      field :name
      field :primary_location_name
      field :active
      field :sub_categories
    end

    edit do
      group :status do
        field :active
        field :visible
      end
      group :name do
        field :name
        field :in_business_since, :enum do
          enum { [*1950..2012].reverse.map{|year| [year.to_s, Date.new(year)]} }
        end
      end
      group :contact_info do
        field :email
        field :phone_main
        field :phone_mobile
        field :phone_fax
      end
      group :website do
        field :website_url
      end
      group :address do
        field :locations
      end
      group :description do
        field :about
        field :description
        field :general_info
      end
      # group :service_area do
      #   # field :service_areas
      # end
      # group :categories do
      #   # field :categories
      # end
      group :operations do
        field :offers_24_hour_service
        field :offers_emergency_service
      end
      group :insurance do
        field :insured
        field :insurance_state
        field :insurance_certificate
        field :insurance_valid_from
        field :insurance_valid_until
      end
      group :license_and_bonding do
        field :business_licenses
        field :personal_licenses
      end
      group :business_status do
        field :business_filings
      end
      group :affiliations do
        field :affiliations
      end
      group :associations do
        field :associations
      end
      group :certifications do
        field :certifications
      end
      group :others do
        field :discounts
        field :users
      end
    end
  end

  config.model Affiliation do
    visible false
    parent Company
  end

  config.model Association do
    visible false
    parent Company
  end

  config.model Certification do
    visible false
    parent Company
  end

  config.model BusinessFiling do
    visible false
    parent Company

    object_label_method :display_identifier

    configure(:raw_data) { visible false }

    edit do
      field :issuing_state
      field :number
    end
  end

  config.model BusinessLicense do
    visible false
    parent Company

    object_label_method :display_identifier

    configure(:raw_data) { visible false }

    edit do
      field :issuing_state
      field :number
    end
  end

  config.model PersonalLicense do
    visible false
    parent Company

    object_label_method :display_identifier

    configure(:raw_data) { visible false }

    edit do
      field :issuing_state
      field :number
    end
  end

  config.model Discount do
    visible false
    parent Company

    configure(:market, :belongs_to_association) do
      associated_collection_scope do
        company = bindings[:object].company || bindings[:form].parent_builder.object
        Proc.new do |scope|
          scope.where(id: company.market_ids) if company.is_a? Company
        end
      end
    end
  end


  config.model Category do

    list do
      field :name
      field :sub_categories
    end
    edit do
      field :name
      field :sub_categories
    end
  end
  config.model SubCategory do
    visible false
    parent Category

    configure(:company_categories) { visible false }

    list do
      field :name
      field :category
    end

    edit do
      field :name
    end
  end

  config.model CompanyCategory do
    visible false
  end
  config.model CompanyServiceArea do
    visible false
  end

  config.model DiscountType do
    list do
      field :name
    end
    edit do
      field :name
    end
  end

  config.model FilingStatus do
    visible false
  end
  config.model FilingType do
    visible false
  end

  config.model LicenseStatus do
    visible false
  end
  config.model LicenseType do
    visible false
  end
  config.model PersonalLicenseType do
    visible false
  end
  config.model BusinessLicenseType do
    visible false
  end

  config.model Location do
    visible false
  end

  config.model Market do
    configure(:discounts) { visible false }
    configure(:company_service_areas) { visible false }
    configure(:companies) { visible false }

    list do
      field :name
      field :service_areas
    end
    edit do
      field :name
      field :service_areas
    end
  end
  config.model ServiceArea do
    visible false
    parent Market

    configure(:companies) { visible false }

    list do
      field :name
      field :market
    end
    edit do
      field :name
    end
  end

  user_config = Proc.new do
    # configure(:created_by_user) { visible false }
    # configure(:updated_by_user) { visible false }
    # configure(:auth_tokens) { visible false }
    # configure(:password_resets) { visible false }
    # configure(:active) { visible false }
    # configure(:email) { visible false }
    # configure(:first_name) { visible false }
    # configure(:middle_name) { visible false }
    # configure(:last_name) { visible false }
    # configure(:role) { visible false }
    # configure(:logged_in_at) { visible false }
    configure(:password_digest) { visible false }

    # Sections:
    list do
      field :display_name do
        sortable :last_name
      end
      field :company
      field :logged_in_at
      field :role
      field :active
    end
    edit do
      field :active
      field :first_name
      field :middle_name
      field :last_name
      field :company
      field :email
      field :role, :enum do
        enum { ::User::ROLES }
      end
    end
  end
  config.model(User, &user_config)
  config.model CompanyAdmin do
    instance_eval(&user_config)
    visible false
  end
  config.model Admin do
    instance_eval(&user_config)
    parent User
  end

  user_auth_token_config = Proc.new do
    visible false
    parent User

    #  configure(:user, :belongs_to_association)
    #  configure(:token, :string)
    #  configure(:type, :string)
    #  configure(:fullfilled_by_ip, :string)
    #  configure(:fullfilled_at, :datetime)
    #  configure(:email_sent_at, :datetime)
    #  configure(:expires_at, :datetime)
    #  configure(:created_by_ip, :string)
  end
  config.model(UserAuthToken, &user_auth_token_config)
  config.model PasswordReset do
    instance_eval(&user_auth_token_config)
    visible false
  end

  config.model Country do
    visible false
  end
  config.model State do
    visible false
  end

  config.model CompanySearch do
    visible false
  end
end
