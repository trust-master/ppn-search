class RenameStatusTables < ActiveRecord::Migration
  def change
    rename_table :license_status, :license_statuses
    rename_table  :filing_status,  :filing_statuses
  end
end
