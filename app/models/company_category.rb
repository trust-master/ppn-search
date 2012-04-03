# This class is a join model between Company and SubCategory
class CompanyCategory < ActiveRecord::Base
  belongs_to :company
  belongs_to :sub_category

  attr_accessible :sub_category_id, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id

  delegate :category, :category_name,  to: :sub_category
  delegate :name, to: :sub_category, prefix: true
end



# == Schema Information
#
# Table name: company_categories
#
#  id              :integer         not null, primary key
#  company_id      :integer
#  sub_category_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

