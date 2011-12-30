class FilingStatus < ActiveRecord::Base
  set_table_name :filing_status # b/c AR doesn't listen to AS::Inflections :-(
  has_many :business_filings
end

