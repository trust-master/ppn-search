# For the record, this migration was built from a series of previous migrations. As I was the only one working on
# development of this application at the time, I felt it was appropriate to create a new migration that consolidated all
# the previous ones, thus making life easier. That, and I needed to make changes to just about every table. See git
# revision e68e3d6ce14d66b8cb49f4ff610593501749dfe9 if you want to see what this migration was based upon.
#
class SetUpDatabase < ActiveRecord::Migration
  def change

    create_table "companies", :force => true do |t|
      t.boolean  :active, :nil => false, :default => false # was "is_active"
      t.boolean  :visible, :nil => false, :default => false
      t.datetime :deleted_at
      t.references :deleted_by_user
      t.string   :admin_email, :nil => false

      t.string   "name", :nil => false

      t.string   :email # was "email_address"
      t.string   :phone_main # was "main_phone_number"
      t.string   :phone_mobile # was "mobile_phone_number"
      t.string   :phone_fax # was "fax_number"
      t.string   :website_url # was "web_site"

      # See 'locations' table:
      #  t.string   "address_1"
      #  t.string   "address_2"
      #  t.string   "city"
      #  t.string   "state"
      #  t.string   "zip_code"

      t.date     "in_business_since"
      t.string   "about"
      t.text     "description"
      t.text     "general_info"

      t.boolean  :offers_24_hour_service, :nil => false, :default => false # was "twenty_four_hour_service"
      t.boolean  :offers_emergency_service, :nil => false, :default => false # was "emergency_services"

      t.boolean  :insured, :nil => false, :default => false # was "is_insurance"
      t.references :insurance_state
      t.string   :insurance_certificate # was "certificate_of_insurance_filename" # This is a CarrierWave file upload identifier column
      t.date     :insurance_valid_from
      t.date     :insurance_valid_until
      # t.integer  "insurance_expiration_month"
      # t.integer  "insurance_expiration_year"

      # was "personal_license_type"
      # t.string     "personal_license_number"

      # was "business_certificate_type"
      # was "business_certificate_number"

      # was "business_status_type"
      # was "filing_number"

      # See 'discounts' table:
      #  t.string   "discount_type"
      #  t.string   "discount_title"
      #  t.string   "discount_description"
      #  t.date     "discount_start_date"
      #  t.date     "discount_end_date"

      # t.integer  "company_category_id"

      #t.string :logo  # This is a CarrierWave file upload identifier column # FIXME: Do Mike and Dan want this??

      t.timestamps
    end
    add_index :companies, :deleted_by_user_id
    add_index :companies, :insurance_state_id

    %w[associations affiliations].each do |table_name|
      create_table table_name, :force => true do |t|
        t.references :company, :nil => false
        t.string   "name", :nil => false
        t.string   "title"
        t.text     "description"

        t.date     :started_on, :nil => false
        # t.integer  "start_month"
        # t.integer  "start_year"
        t.date     :ended_on
        # t.integer  "end_month"
        # t.integer  "end_year"
        # t.boolean  "current_member"

        t.string   :url # was "uri"

        t.timestamps
      end

      add_index table_name, :company_id
    end

    create_table "certifications", :force => true do |t|
      t.references :company, :nil => false

      t.string   "name", :nil => false
      t.string   "title"
      t.text "description"

      t.string :certificate # was "certificate_filename" # This is a CarrierWave file upload identifier column

      t.timestamps
    end
    add_index :certifications, :company_id

    create_table "users", :force => true do |t|
      t.boolean  :active, :nil => false, :default => false
      t.references :company, :nil => false
      t.string   :email, :nil => false # was "email_address"

      t.string   :password_digest, :nil => false # using bcrypt, so salt is built in
      #t.string   "password_hash"
      #t.string   "password_salt"

      t.string   "first_name", :nil => false
      t.string   :middle_name
      t.string   "last_name", :nil => false

      t.references :created_by_user # was "created_by"
      t.references :updated_by_user # was "updated_by"

      t.string   :role, :nil => false, :default => "User" # going to use CanCan, so we'll store User role as a string
      # t.boolean  "is_admin"

      t.datetime :logged_in_at
      t.timestamps
    end
    add_index :users, :company_id
    add_index :users, :created_by_user_id
    add_index :users, :updated_by_user_id


    create_table :user_password_resets, :force => true do |t|
      t.references :user, :nil => false
      t.string     :token, :nil => false
      t.string     :requested_by_ip, :nil => false
      t.datetime   :email_sent_at # for keeping track of when the email actually sends (in case it's in a queue)
      t.datetime   :expires_at, :nil => false # separate from timestamps so we can push the expiration between edit/update actions
      t.timestamps
    end
    add_index :user_password_resets, :user_id


    # If Mike and Dan decide to go this route
    #  create_table :memberships, :force => true do |t|
    #    t.references :user, :nil => false
    #    t.references :company, :nil => false
    #    role :string, :nil => false, :default => "User"
    #  end
    #  add_index :memberships, :user_id
    #  add_index :memberships, :company_id

    #create_table "business_certificates", :force => true do |t|
    create_table "business_licenses", :force => true do |t|
      t.references :company, :nil => false

      t.references :type, :nil => false # was "license_type"
      t.references :status, :nil => false
      t.string     :number, :nil => false # was "license_number"

      t.string   "name", :nil => false
      t.string   :doing_business_as # was "business_as"

      t.string   "address"
      t.string   :address2
      t.string   :city
      t.string   :state
      t.string   :zip
      # t.string "city_state_zip"

      t.string   "company_structure"

      t.date     :issued_on, :nil => false # was "original_issue_date"
      t.date     :expires_on, :nil => false # was "expiration_date"
      t.date     :printed_on # was "print_date"

      t.boolean  "enforcement_action", :nil => false, :default => false

      t.string   "responsible_person_name"
      t.string   "responsible_person_license_number"

      t.string   "contractors_phone_number"

      t.timestamps
    end
    add_index :business_licenses, :company_id
    add_index :business_licenses, :type_id
    add_index :business_licenses, :status_id


    #create_table "personal_certificates", :force => true do |t|
    create_table :personal_licenses, :force => true do |t|
      t.references :company

      t.references :type, :nil => false # was "certificate_type"
      t.references :status, :nil => false
      t.string     :number, :nil => false # was "license_number"

      t.string   "name", :nil => false

      t.string   "address"
      t.string   :address2
      t.string   :city
      t.string   :state
      t.string   :zip

      t.date     :issued_on, :nil => false
      t.date     :expires_on, :nil => false
      t.date     :printed_on # was "print_date"

      t.string   "continuing_education"

      t.timestamps
    end
    add_index :personal_licenses, :company_id
    add_index :personal_licenses, :type_id
    add_index :personal_licenses, :status_id

    create_table :license_types, :force => true do |t|
      t.string :name, :nil => false
      t.timestamps
    end

    create_table :license_status, :force => true do |t|
      t.string :name, :nil => false
      t.timestamps
    end

    create_table :business_filings, :force => true do |t|
      t.references :company

      t.references :type, :nil => false
      t.references :status, :nil => false
      t.string     :number, :nil => false

      t.string   :name, :nil => false

      t.text     :registered_office_address
      #  t.string   "address"
      #  t.string   :address2
      #  t.string   :city
      #  t.string   :state
      #  t.string   :zip

      t.date     :originally_filed_on, :nil => false
      t.date     :in_good_standing_as_of

      t.string   :chapter
      t.string   :duration # FIXME: What type of column is this???

      t.string   :agent_name

      t.timestamps
    end
    add_index :business_filings, :company_id
    add_index :business_filings, :type_id
    add_index :business_filings, :status_id

    create_table :filing_types, :force => true do |t|
      t.string :name, :nil => false
      t.timestamps
    end

    create_table :filing_status, :force => true do |t|
      t.string :name, :nil => false
      t.timestamps
    end

    create_table :categories, :force => true do |t|
      t.string :name, :nil => false
      t.timestamps
    end

    create_table :sub_categories, :force => true do |t|
      t.references :category, :nil => false
      t.string :name, :nil => false
      t.timestamps
    end
    add_index :sub_categories, :category_id

    create_table "company_categories", :force => true do |t|
      t.references :company, :nil => false
      t.references :sub_category, :nil => false

      # t.string   "name"

      t.timestamps
    end
    add_index :company_categories, :company_id
    add_index :company_categories, :sub_category_id

    #  create_table "company_subcategories", :force => true do |t|
    #    t.string   "name"
    #    t.timestamps
    #  end

    create_table :discount_types, :force => true do |t|
      t.string   :name, :nil => false
      t.timestamps
    end

    create_table "discounts", :force => true do |t|
      t.references :company, :nil => false
      t.references :type, :nil => false # was "type_id"

      t.string   "title", :nil => false
      t.string   "description"

      t.string :image # was "image_filename" # This is a CarrierWave file upload identifier column

      t.references :market

      t.date     "start_date"
      t.date     "end_date"

      t.timestamps
    end
    add_index :discounts, :company_id
    add_index :discounts, :type_id
    add_index :discounts, :market_id

    #create_table "service_area_coverages", :force => true do |t|
    create_table :company_service_areas, :force => true do |t|
      t.references :company, :nil => false
      t.references :service_area, :nil => false
      t.boolean    :partial_only, :nil => false, :default => false # was "coverage_type"
      t.timestamps
    end
    add_index :company_service_areas, :company_id
    add_index :company_service_areas, :service_area_id

    create_table :markets, :force => true do |t|
      t.string   :name, :nil => false
      t.timestamps
    end

    create_table "service_areas", :force => true do |t|
      t.references :market, :nil => false
      t.string   "name", :nil => false
      t.timestamps
    end
    add_index :service_areas, :market_id

    create_table :countries, :force => true do |t|
      t.string   :name, :nil => false
      t.timestamps
    end

    # This is States, within a country. Note that some countries don't have states, so `location` can't depend on _only_
    # this table.
    create_table :states, :force => true do |t|
      t.references :country
      t.string   :name, :nil => false
      t.timestamps
    end
    add_index :states, :country_id

    create_table :locations, :force => true do |t|
      t.references :company, :nil => false

      t.string     :city, :nil => false
      t.references :state
      t.string     :zip # String, so it can be used for Canada/Mexico/UK if necessary.
                        # Should be normalized, though (remove [^A-Za-z0-9]). reformat based on country at display-time
      t.references :country

      t.timestamps
    end
    add_index :locations, :company_id
    add_index :locations, :state_id
    add_index :locations, :country_id
  end
end
