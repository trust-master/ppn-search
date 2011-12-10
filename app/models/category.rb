# == Schema Information
#
# Table name: company_categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :sub_categories
  has_many :company_categories, :through => :sub_categories
  has_many :companies, :through => :company_categories
end
