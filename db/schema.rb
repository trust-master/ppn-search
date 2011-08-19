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

ActiveRecord::Schema.define(:version => 20110819131427) do

  create_table "affiliations", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.boolean  "current_member"
    t.integer  "start_month"
    t.integer  "start_year"
    t.integer  "end_month"
    t.integer  "end_year"
    t.string   "uri"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "associations", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.boolean  "current_member"
    t.integer  "start_month"
    t.integer  "start_year"
    t.integer  "end_month"
    t.integer  "end_year"
    t.string   "uri"
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "title"
    t.string   "certificate_filename"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.date     "in_business_since"
    t.string   "email_address"
    t.string   "main_phone_number"
    t.string   "mobile_phone_number"
    t.string   "fax_number"
    t.string   "web_site"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "about"
    t.string   "description"
    t.string   "general_info"
    t.boolean  "twenty_four_hour_service"
    t.boolean  "emergency_services"
    t.boolean  "is_insurance"
    t.integer  "insurance_expiration_month"
    t.integer  "insurance_expiration_year"
    t.string   "personal_license_type"
    t.string   "personal_license_number"
    t.string   "business_certificate_type"
    t.string   "business_certificate_number"
    t.string   "business_status_type"
    t.string   "filing_number"
    t.string   "discount_type"
    t.string   "discount_title"
    t.string   "discount_description"
    t.date     "discount_start_date"
    t.date     "discount_end_date"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_category_id"
    t.string   "certificate_of_insurance_filename"
  end

  create_table "company_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_subcategories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts", :force => true do |t|
    t.string   "description"
    t.integer  "market_id"
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "image_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "type_id"
  end

  create_table "service_area_coverages", :force => true do |t|
    t.integer  "company_id"
    t.integer  "service_area_id"
    t.integer  "coverage_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email_address"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "updated_by"
    t.boolean  "is_admin"
  end

end
