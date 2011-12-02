class CreateDiscounts < ActiveRecord::Migration
    def self.up
        create_table :discounts do |t|
            t.integer :type
            t.string :description
            t.integer :market_id
            t.string :title

            t.date :start_date
            t.date :end_date

            t.string :image_filename
            t.timestamps
        end
    end

    def self.down
        drop_table :discounts
    end
end
