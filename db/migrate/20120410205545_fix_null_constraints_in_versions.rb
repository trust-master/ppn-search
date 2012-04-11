class FixNullConstraintsInVersions < ActiveRecord::Migration
  def up
    change_column_null :versions, :published, true
  end

  def down
    change_column_null :versions, :published, false, false
  end
end
