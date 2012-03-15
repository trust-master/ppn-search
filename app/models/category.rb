class Category < ActiveRecord::Base
  has_many :sub_categories
  has_many :company_categories, through: :sub_categories
  has_many :companies,          through: :company_categories

  accepts_nested_attributes_for :sub_categories, allow_destroy: true

  attr_accessible :name, :sub_categories_attributes, as: :admin

  validates :name, presence: true
  validates_associated :sub_categories
end


# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

