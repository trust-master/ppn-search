class SwitchSerializedColsToHstore < ActiveRecord::Migration
  def up
    tables = [:personal_licenses, :business_licenses, :business_filings]
    tables.each do |table|
      remove_column table, :raw_data
      add_column    table, :raw_data, 'hstore'
      execute "CREATE INDEX #{table}_raw_data ON #{table} USING GIN(raw_data);"
    end
  end

  def down
    tables = [:personal_licenses, :business_licenses, :business_filings]
    tables.each do |table|
      remove_index  table, name: "#{table}_raw_data"
      remove_column table, :raw_data
      add_column    table, :raw_data, :text
    end
  end
end
