class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :company_categories
  has_many :companies, :through => :company_categories
end

