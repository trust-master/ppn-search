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

ActiveRecord::Schema.define(:version => 20111210050744) do

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

  create_table "business_filings", :force => true do |t|
    t.integer  "company_id"
    t.integer  "type_id"
    t.integer  "status_id"
    t.string   "number"
    t.string   "name"
    t.text     "registered_office_address"
    t.date     "originally_filed_on"
    t.date     "in_good_standing_as_of"
    t.string   "chapter"
    t.string   "duration"
    t.string   "agent_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_licenses", :force => true do |t|
    t.integer  "company_id"
    t.integer  "type_id"
    t.integer  "status_id"
    t.string   "number"
    t.string   "name"
    t.string   "doing_business_as"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "company_structure"
    t.date     "issued_on"
    t.date     "expires_on"
    t.date     "printed_on"
    t.boolean  "enforcement_action",                :default => false
    t.string   "responsible_person_name"
    t.string   "responsible_person_license_number"
    t.string   "contractors_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "company_categories", :force => true do |t|
    t.integer  "company_id"
    t.integer  "sub_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_service_areas", :force => true do |t|
    t.integer  "company_id"
    t.integer  "service_area_id_id"
    t.boolean  "partial_only",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "markets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_licenses", :force => true do |t|
    t.integer  "company_id"
    t.integer  "type_id"
    t.integer  "status_id"
    t.string   "number"
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.date     "issued_on"
    t.date     "expires_on"
    t.date     "printed_on"
    t.string   "continuing_education"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_areas", :force => true do |t|
    t.integer  "market_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_categories", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_password_resets", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "requested_by_ip"
    t.datetime "email_sent_at"
    t.datetime "expires_at"
    t.datetime "created_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
