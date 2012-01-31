class ExpandLicenseTypes < ActiveRecord::Migration
  def change
    add_column :license_types, :type,     :string,  nil: false
    add_column :license_types, :state_id, :integer, nil: false
  end
end
