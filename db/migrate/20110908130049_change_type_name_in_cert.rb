class ChangeTypeNameInCert < ActiveRecord::Migration
    def self.up
        change_table :personal_certificates do |t|
            t.string :certificate_type
        end
        remove_column :personal_certificates, :type

        change_table :personal_certificates do |t|
            t.string :address
        end
        remove_column :personal_certificates, :addres
    end

    def self.down
        change_table :personal_certficiates do |t|
            t.string :type
        end
        remove_column :personal_certificates, :type

        change_table :personal_certficiates do |t|
            t.string :address
        end
        remove_column :personal_certificates, :addres
    end
end
