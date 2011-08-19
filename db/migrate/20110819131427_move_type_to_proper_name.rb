class MoveTypeToProperName < ActiveRecord::Migration
    def self.up
        change_table :discounts do |t|
            t.integer :type_id
        end
        remove_column :discounts, :type
    end

    def self.down
        remove_column :discounts, :type_id
        change_table :discounts do |t|
            t.integer :type
        end
    end
end
