class RemoveOldCarrierwaveColumns < ActiveRecord::Migration
  def up
    remove_column :certifications, :certificate
    remove_column :companies,      :insurance_certificate
    remove_column :discounts,      :image
  end
  def down
    add_column :certifications, :certificate,           :string
    add_column :companies,      :insurance_certificate, :string
    add_column :discounts,      :image,                 :string
  end
end

