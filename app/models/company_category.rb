# This class is a join model between Company and SubCategory
class CompanyCategory < ActiveRecord::Base
  belongs_to :company
  belongs_to :sub_category
  # belongs_to :category, :through => :sub_category # this is not possible, with AR, yet
end

