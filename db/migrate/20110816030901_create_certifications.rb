class CreateCertifications < ActiveRecord::Migration
    def self.up
        create_table :certifications do |t|
            t.integer :company_id
            
            t.string :name
            t.string :title
            t.string :certificate_filename
            t.string :description
            
            t.timestamps
        end
    end

    def self.down
        drop_table :certifications
    end
end
