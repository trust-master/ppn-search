class AddCompanyIdToBussinessCerts < ActiveRecord::Migration
    def self.up        
        change_table :business_certificates do |t|
            t.integer :company_id
        end
    end

    def self.down
        remove_column :business_certificates, :company_id
    end
end
