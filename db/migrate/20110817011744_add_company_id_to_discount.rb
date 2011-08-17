class AddCompanyIdToDiscount < ActiveRecord::Migration
    def self.up
        change_table :discounts do |t|
            t.integer :company_id
        end
    end

    def self.down
        remove_column :discounts, :company_id
    end
end
