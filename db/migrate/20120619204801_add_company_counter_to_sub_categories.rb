class AddCompanyCounterToSubCategories < ActiveRecord::Migration
  def up
    add_column :categories,     :companies_count, :integer, null: false, default: 0
    add_column :sub_categories, :companies_count, :integer, null: false, default: 0
    SubCategory.reset_column_information
    Category.reset_column_information

    CompanyCategory.counter_culture_fix_counts
  end

  def down
    remove_column :sub_categories, :companies_count
    remove_column :categories,     :companies_count
  end
end
