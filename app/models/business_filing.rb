class BusinessFiling < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => 'FilingType'
  belongs_to :status, :class_name => 'FilingStatus'
end

