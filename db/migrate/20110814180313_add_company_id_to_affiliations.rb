class AddCompanyIdToAffiliations < ActiveRecord::Migration
    def self.up
        change_table :affiliations do |t|
            t.integer :company_id
        end
    end

    def self.down
        remove_column :affiliations, :company_id
    end
end
