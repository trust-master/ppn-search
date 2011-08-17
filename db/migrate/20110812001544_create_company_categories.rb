class CreateCompanyCategories < ActiveRecord::Migration
    def self.up
        create_table :company_categories do |t|
            t.column :name, :string
            t.timestamps
        end
    end

    def self.down
        drop_table :company_categories
    end
end
