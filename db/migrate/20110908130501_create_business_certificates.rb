class CreateBusinessCertificates < ActiveRecord::Migration
    def self.up
        create_table :business_certificates do |t|
            t.string :name
            t.string :business_as
            t.string :address
            t.string :city_state_zip
            t.string :license_number
            t.string :license_type
            t.string :company_structure
            t.string :status
            t.date :original_issue_date
            t.date :expiration_date
            t.date :print_date
            t.string :responsible_person_name
            t.string :responsible_person_license_number
            t.string :contractors_phone_number
            t.string :enforcement_action

            t.timestamps
        end
    end

    def self.down
        drop_table :business_certificates
    end
end



