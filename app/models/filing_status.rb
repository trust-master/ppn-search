class FilingStatus < ActiveRecord::Base
  has_many :business_filings
end
