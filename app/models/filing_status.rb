class FilingStatus < ActiveRecord::Base
  self.table_name = :filing_status # b/c AR doesn't listen to AS::Inflections :-(
  has_many :business_filings
end


# == Schema Information
#
# Table name: filing_status
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

