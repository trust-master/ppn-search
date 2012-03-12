class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :company_categories
  has_many :companies, :through => :company_categories

  delegate :name, to: :category, prefix: true # will produce category_name method
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

