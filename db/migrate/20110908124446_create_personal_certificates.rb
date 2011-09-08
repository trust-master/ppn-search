class CreatePersonalCertificates < ActiveRecord::Migration
    def self.up
        create_table :personal_certificates do |t|
            t.integer :company_id
            t.string :name
            t.string :addres
            t.string :type
            t.string :status
            t.date :print_date
            t.string :continuing_education
        t.timestamps
    end
    end

    def self.down
        drop_table :personal_certificates
    end
end