class FilingType < ActiveRecord::Base
  has_many :business_filings
end


# == Schema Information
#
# Table name: filing_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

