# == Schema Information
#
# Table name: business_filings
#
#  id                        :integer         not null, primary key
#  company_id                :integer
#  type_id                   :integer
#  status_id                 :integer
#  number                    :string(255)
#  name                      :string(255)
#  registered_office_address :text
#  originally_filed_on       :date
#  in_good_standing_as_of    :date
#  chapter                   :string(255)
#  duration                  :string(255)
#  agent_name                :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

class BusinessFiling < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => 'FilingType'
  belongs_to :status, :class_name => 'FilingStatus'
end
