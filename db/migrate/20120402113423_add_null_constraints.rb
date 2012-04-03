class AddNullConstraints < ActiveRecord::Migration
  def up
    change_column_null :users,                 :active,                   false, false
    change_column_null :personal_licenses,     :enforcement_action,       false, false
    change_column_null :companies,             :active,                   false, false
    change_column_null :companies,             :visible,                  false, false
    change_column_null :companies,             :offers_24_hour_service,   false, false
    change_column_null :companies,             :offers_emergency_service, false, false
    change_column_null :companies,             :insured,                  false, false
    change_column_null :business_licenses,     :enforcement_action,       false, false
    change_column_null :company_service_areas, :partial_only,             false, false
    change_column_null :pages,                 :published,                false, false
    change_column_null :versions,              :published,                false, false

    [ :affiliations, :associations, :categories, :certifications, :companies, :company_categories,
        :company_service_areas, :countries, :discount_types, :discounts, :filing_status, :filing_types,
        :license_status, :license_types, :locations, :markets, :service_areas, :states, :sub_categories,
        :user_auth_tokens, :users ].each do |table|

      change_column_null table, :created_at, false
      change_column_null table, :updated_at, false
    end

    change_column_null :user_auth_tokens, :expires_at, false

  end

  def down
    change_column_null :users,                 :active,                   true
    change_column_null :personal_licenses,     :enforcement_action,       true
    change_column_null :companies,             :active,                   true
    change_column_null :companies,             :visible,                  true
    change_column_null :companies,             :offers_24_hour_service,   true
    change_column_null :companies,             :offers_emergency_service, true
    change_column_null :companies,             :insured,                  true
    change_column_null :business_licenses,     :enforcement_action,       true
    change_column_null :company_service_areas, :partial_only,             true
    change_column_null :pages,                 :published,                true
    change_column_null :versions,              :published,                true

    [ :affiliations, :associations, :categories, :certifications, :companies, :company_categories,
        :company_service_areas, :countries, :discount_types, :discounts, :filing_status, :filing_types,
        :license_status, :license_types, :locations, :markets, :service_areas, :states, :sub_categories,
        :user_auth_tokens, :users ].each do |table|

      change_column_null table, :created_at, true
      change_column_null table, :updated_at, true
    end

    change_column_null :user_auth_tokens, :expires_at, true
  end
end
