class Category < ActiveRecord::Base
  default_scope order(:sort_order, :id)

  has_many :sub_categories, inverse_of: :category, dependent: :destroy
  has_many :company_categories, through: :sub_categories
  has_many :companies,          through: :company_categories

  accepts_nested_attributes_for :sub_categories, allow_destroy: true

  attr_accessible :name, :sub_categories_attributes, :sort_order, as: :admin

  validates_presence_of :name
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

