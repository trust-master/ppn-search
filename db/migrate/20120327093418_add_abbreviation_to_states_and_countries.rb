class AddAbbreviationToStatesAndCountries < ActiveRecord::Migration
  def up
    add_column :states,    :abbreviation, :string, null: false
    add_column :countries, :abbreviation, :string, null: false
  end

  def down
    drop_column :states,    :abbreviation
    drop_column :countries, :abbreviation
  end
end
