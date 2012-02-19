class RestructureLicensesAndBusinessFilings < ActiveRecord::Migration
  def up
    [:business_licenses, :personal_licenses, :business_filings].each do |table|
      drop_table table
    end

    create_table :business_licenses do |t|

      t.references :company,           nil: false
      t.references :issuing_state,     nil: false
      t.references :type,              nil: false
      t.references :status,            nil: false

      t.string     :number,            nil: false

      t.string     :application_number

      t.date       :expires_on
      t.date       :effective_on

      t.date       :issued_on
      t.date       :printed_on

      t.boolean    :enforcement_action,  nil: false, default: false

      #=========

      t.string   :name,                  nil: false
      t.string   :doing_business_as

      t.text     :address # there's no need to separate these fields...

      t.string   :phone_number

      t.string   :responsible_person_license_number

      t.text     :raw_data

      t.timestamps
    end

    create_table :personal_licenses do |t|

      t.references :company,       nil: false
      t.references :issuing_state, nil: false

      t.references :type,          nil: false
      t.references :status,        nil: false

      t.string     :number,        nil: false
      t.string     :application_number

      t.string     :continuing_education
      t.boolean    :enforcement_action,  nil: false, default: false

      t.string     :name,          nil: false

      t.text     :address # there's no need to separate these fields...

      t.date     :issued_on
      t.date     :expires_on
      t.date     :printed_on
      t.date     :effective_on

      t.text     :raw_data

      t.timestamps
    end

    create_table :business_filings do |t|
      t.references :company
      t.references :issuing_state
      t.references :type,                         nil: false
      t.references :status,                       nil: false

      t.string     :number,                       nil: false

      t.string     :name,                         nil: false

      t.text       :registered_office_address # there's no need to separate these fields...
      t.text       :chief_executive_officer
      t.string     :home_jurisdiction

      t.date       :originally_filed_on,                  nil: false
      t.date       :last_annually_filed_on
      t.date       :renewal_due_on

      t.string     :registered_agents

      t.text       :raw_data

      t.timestamps
    end

  end

  def down
    [:business_licenses, :personal_licenses, :business_filings].each do |table|
      drop_table table
    end

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

  end
end
