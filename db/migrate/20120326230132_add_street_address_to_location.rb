class AddStreetAddressToLocation < ActiveRecord::Migration
  def up
    change_table :locations do |t|
      t.string :street
      t.string :street2
    end
  end
  def down
    change_table :locations do |t|
      t.remove :street
      t.remove :street2
    end
  end
end
