class FilingStatus < ActiveRecord::Base
  has_many :business_filings
end



# == Schema Information
#
# Table name: filing_status
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

