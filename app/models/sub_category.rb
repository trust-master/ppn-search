class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :company_categories, dependent: :destroy
  has_many :companies,          through: :company_categories

  attr_accessible :name, :category_id, as: :admin

  delegate :name, to: :category, prefix: true # will produce category_name method

  validates            :name, :category, presence: true
  validates_associated :category
end


# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer         not null, primary key
#  category_id :integer
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

