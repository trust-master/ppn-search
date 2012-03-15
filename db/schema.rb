# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120314030748) do

  create_table "affiliations", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.date     "started_on"
    t.date     "ended_on"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affiliations", ["company_id"], :name => "index_affiliations_on_company_id"

  create_table "associations", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.date     "started_on"
    t.date     "ended_on"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associations", ["company_id"], :name => "index_associations_on_company_id"

  create_table "business_filings", :force => true do |t|
    t.integer  "company_id"
    t.integer  "issuing_state_id"
    t.integer  "type_id"
    t.integer  "status_id"
    t.string   "number"
    t.string   "name"
    t.text     "registered_office_address"
    t.text     "chief_executive_officer"
    t.string   "home_jurisdiction"
    t.date     "originally_filed_on"
    t.date     "last_annually_filed_on"
    t.date     "renewal_due_on"
    t.string   "registered_agents"
    t.text     "raw_data"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "fetched_at"
  end

  create_table "business_licenses", :force => true do |t|
    t.integer  "company_id"
    t.integer  "issuing_state_id"
    t.integer  "type_id"
    t.integer  "status_id"
    t.string   "number"
    t.string   "application_number"
    t.date     "expires_on"
    t.date     "effective_on"
    t.date     "issued_on"
    t.date     "printed_on"
    t.boolean  "enforcement_action",                :default => false
    t.string   "name"
    t.string   "doing_business_as"
    t.text     "address"
    t.string   "phone_number"
    t.string   "responsible_person_license_number"
    t.text     "raw_data"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.datetime "fetched_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.string   "certificate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certifications", ["company_id"], :name => "index_certifications_on_company_id"

  create_table "companies", :force => true do |t|
    t.boolean  "active",                   :default => false
    t.boolean  "visible",                  :default => false
    t.datetime "deleted_at"
    t.integer  "deleted_by_user_id"
    t.string   "admin_email"
    t.string   "name"
    t.string   "email"
    t.string   "phone_main"
    t.string   "phone_mobile"
    t.string   "phone_fax"
    t.string   "website_url"
    t.date     "in_business_since"
    t.string   "about"
    t.text     "description"
    t.text     "general_info"
    t.boolean  "offers_24_hour_service",   :default => false
    t.boolean  "offers_emergency_service", :default => false
    t.boolean  "insured",                  :default => false
    t.integer  "insurance_state_id"
    t.string   "insurance_certificate"
    t.date     "insurance_valid_from"
    t.date     "insurance_valid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["deleted_by_user_id"], :name => "index_companies_on_deleted_by_user_id"
  add_index "companies", ["insurance_state_id"], :name => "index_companies_on_insurance_state_id"

  create_table "company_categories", :force => true do |t|
    t.integer  "company_id"
    t.integer  "sub_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_categories", ["company_id"], :name => "index_company_categories_on_company_id"
  add_index "company_categories", ["sub_category_id"], :name => "index_company_categories_on_sub_category_id"

  create_table "company_service_areas", :force => true do |t|
    t.integer  "company_id"
    t.integer  "service_area_id"
    t.boolean  "partial_only",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_service_areas", ["company_id"], :name => "index_company_service_areas_on_company_id"
  add_index "company_service_areas", ["service_area_id"], :name => "index_company_service_areas_on_service_area_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discount_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts", :force => true do |t|
    t.integer  "company_id"
    t.integer  "type_id"
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.integer  "market_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discounts", ["company_id"], :name => "index_discounts_on_company_id"
  add_index "discounts", ["market_id"], :name => "index_discounts_on_market_id"
  add_index "discounts", ["type_id"], :name => "index_discounts_on_type_id"

  create_table "filing_status", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filing_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "license_status", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "license_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "state_id"
  end

  create_table "locations", :force => true do |t|
    t.integer  "company_id"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["company_id"], :name => "index_locations_on_company_id"
  add_index "locations", ["country_id"], :name => "index_locations_on_country_id"
  add_index "locations", ["state_id"], :name => "index_locations_on_state_id"

  create_table "markets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_licenses", :force => true do |t|
    t.integer  "company_id"
    t.integer  "issuing_state_id"
    t.integer  "type_id"
    t.integer  "status_id"
    t.string   "number"
    t.string   "application_number"
    t.string   "continuing_education"
    t.boolean  "enforcement_action",   :default => false
    t.string   "name"
    t.text     "address"
    t.string   "phone_number"
    t.date     "issued_on"
    t.date     "expires_on"
    t.date     "printed_on"
    t.date     "effective_on"
    t.text     "raw_data"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.datetime "fetched_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "service_areas", :force => true do |t|
    t.integer  "market_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_areas", ["market_id"], :name => "index_service_areas_on_market_id"

  create_table "states", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_id"], :name => "index_states_on_country_id"

  create_table "sub_categories", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_categories", ["category_id"], :name => "index_sub_categories_on_category_id"

  create_table "user_auth_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "type"
    t.string   "fullfilled_by_ip"
    t.datetime "fullfilled_at"
    t.datetime "email_sent_at"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.string   "created_by_ip"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.boolean  "active",             :default => false
    t.integer  "company_id"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "created_by_user_id"
    t.integer  "updated_by_user_id"
    t.string   "role",               :default => "User"
    t.datetime "logged_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["created_by_user_id"], :name => "index_users_on_created_by_user_id"
  add_index "users", ["updated_by_user_id"], :name => "index_users_on_updated_by_user_id"

end
