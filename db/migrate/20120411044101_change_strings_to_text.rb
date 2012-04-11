class ChangeStringsToText < ActiveRecord::Migration
  def change
    change_column :discounts, :description, :text

  end
end