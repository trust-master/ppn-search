class CreateServiceAreaCoverages < ActiveRecord::Migration
    def self.up
        create_table :service_area_coverages do |t|
            t.integer :company_id
            t.integer :service_area_id
            t.integer :coverage_type
            
            t.timestamps
        end
    end

    def self.down
        drop_table :service_area_coverages
    end
end
