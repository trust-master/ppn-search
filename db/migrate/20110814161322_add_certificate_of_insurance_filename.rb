class AddCertificateOfInsuranceFilename < ActiveRecord::Migration
    def self.up
        change_table :companies do |t|
            t.string :certificate_of_insurance_filename
        end
    end

    def self.down
        remove_column :companies, :certificate_of_insurance_filename
    end
end
