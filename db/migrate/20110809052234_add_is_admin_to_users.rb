class AddIsAdminToUsers < ActiveRecord::Migration
    def self.up
        change_table :users do |t|
            t.boolean :is_admin
        end
    end

    def self.down
        remove_column :users, :is_admin
    end
end
