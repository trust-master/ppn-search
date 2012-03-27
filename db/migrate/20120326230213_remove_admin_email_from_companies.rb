class RemoveAdminEmailFromCompanies < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.remove :admin_email
    end
  end

  def down
    change_table :companies do |t|
      t.string :admin_email
    end
  end
end
