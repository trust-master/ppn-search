class AddSortOrderToEnumerationTables < ActiveRecord::Migration
  def change
    add_column :categories,     :sort_order, :integer, default: 0, null: false
    add_column :sub_categories, :sort_order, :integer, default: 0, null: false
    add_column :discount_types, :sort_order, :integer, default: 0, null: false
    add_column :markets,        :sort_order, :integer, default: 0, null: false
    add_column :service_areas,  :sort_order, :integer, default: 0, null: false
  end
end
