class AddCompanyCategoryLinkage < ActiveRecord::Migration
    def self.up
        change_table :companies do |t|
            t.integer :company_category_id
        end
    end

    def self.down
        remove_column :companies, :company_category_id
    end
end
