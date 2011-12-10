class FilingType < ActiveRecord::Base
  has_many :business_filings
end
