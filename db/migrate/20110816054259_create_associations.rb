class CreateAssociations < ActiveRecord::Migration
    def self.up
        create_table :associations do |t|
            t.string   "name"
            t.string   "title"
            t.boolean  "current_member"
            t.integer  "start_month"
            t.integer  "start_year"
            t.integer  "end_month"
            t.integer  "end_year"
            t.string   "uri"
            t.string   "description"

            t.integer  "company_id"
            t.timestamps
        end
    end

    def self.down
        drop_table :associations
    end
end
