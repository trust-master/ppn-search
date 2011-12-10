# == Schema Information
#
# Table name: company_subcategories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CompanyCategory < ActiveRecord::Base
  belongs_to :company
  belongs_to :sub_category
  belongs_to :category, :through => :sub_category
end
