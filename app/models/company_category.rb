# This class is a join model between Company and SubCategory
class CompanyCategory < ActiveRecord::Base
  belongs_to :company, touch: true
  belongs_to :sub_category

  counter_culture :sub_category, column_name: 'companies_count'
  counter_culture [:sub_category, :category], column_name: 'companies_count'

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

