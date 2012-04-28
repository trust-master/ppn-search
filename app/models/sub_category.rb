class SubCategory < ActiveRecord::Base
  # default_scope order('sub_categories.sort_order DESC', :id)

  belongs_to :category, inverse_of: :sub_categories
  has_many :company_categories, dependent: :destroy
  has_many :companies,          through: :company_categories

  attr_accessible :name, :category_id, :sort_order, as: :administrator

  delegate :name, to: :category, prefix: true # will produce category_name method

  validates_presence_of :name, :category, :sort_order
end




# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer         not null, primary key
#  category_id :integer
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  sort_order  :integer         default(0), not null
#

