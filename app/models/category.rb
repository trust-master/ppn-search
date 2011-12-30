class Category < ActiveRecord::Base
  has_many :sub_categories
  has_many :company_categories, :through => :sub_categories
  has_many :companies, :through => :company_categories
end

