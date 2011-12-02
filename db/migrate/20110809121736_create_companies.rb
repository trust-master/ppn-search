class CreateCompanies < ActiveRecord::Migration
    def self.up
        create_table :companies do |t|
            t.column :name, :string
            t.column :in_business_since, :date
            t.column :email_address, :string

            t.column :main_phone_number, :string
            t.column :mobile_phone_number, :string
            t.column :fax_number, :string

            t.column :web_site, :string

            t.column :address_1, :string
            t.column :address_2, :string
            t.column :city, :string
            t.column :state, :string
            t.column :zip_code, :string

            t.column :about, :string
            t.column :description, :string
            t.column :general_info, :string

            t.column :twenty_four_hour_service, :boolean
            t.column :emergency_services, :boolean

            t.column :is_insurance, :boolean
            t.column :insurance_expiration_month, :integer
            t.column :insurance_expiration_year, :integer

            t.column :personal_license_type, :string
            t.column :personal_license_number, :string

            t.column :business_certificate_type, :string
            t.column :business_certificate_number, :string

            t.column :business_status_type, :string
            t.column :filing_number, :string

            t.column :discount_type, :string
            t.column :discount_title, :string
            t.column :discount_description, :string

            t.column :discount_start_date, :date
            t.column :discount_end_date, :date

            t.column :is_active, :boolean
            t.timestamps
        end
    end

    def self.down
        drop_table :companies
    end
end
