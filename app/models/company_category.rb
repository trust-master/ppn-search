# This class is a join model between Company and SubCategory
class CompanyCategory < ActiveRecord::Base
  belongs_to :company
  belongs_to :sub_category
  # belongs_to :category, :through => :sub_category # this is not possible, with AR, yet
end


# == Schema Information
#
# Table name: company_categories
#
#  id              :integer         not null, primary key
#  company_id      :integer
#  sub_category_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

