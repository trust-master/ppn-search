# == Schema Information
#
# Table name: company_categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CompanyCategory < ActiveRecord::Base
end
