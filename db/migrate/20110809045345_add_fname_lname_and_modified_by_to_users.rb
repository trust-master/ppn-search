class AddFnameLnameAndModifiedByToUsers < ActiveRecord::Migration
    def self.up
        change_table :users do |t|
            t.string :first_name
            t.string :last_name
            t.string :updated_by
        end
    end

    def self.down
        remove_column :users, :first_name
        remove_column :users, :last_name
        remove_column :users, :updated_by
    end
end
