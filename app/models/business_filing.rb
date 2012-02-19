class BusinessFiling < ActiveRecord::Base
  belongs_to :type,          class_name: 'FilingType'
  belongs_to :status,        class_name: 'FilingStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company

  serialize :raw_data, Hash

  # attr_accessible :company_id, :type_id, :status_id, :number, :name, :registered_office_address,
  #   :originally_filed_on, :in_good_standing_as_of, :chapter, :duration, :agent_name, :created_at,
  #   :updated_at

end



# == Schema Information
#
# Table name: business_filings
#
#  id                        :integer         not null, primary key
#  company_id                :integer
#  issuing_state_id          :integer
#  type_id                   :integer
#  status_id                 :integer
#  number                    :string(255)
#  name                      :string(255)
#  registered_office_address :text
#  chief_executive_officer   :text
#  home_jurisdiction         :string(255)
#  originally_filed_on       :date
#  last_annually_filed_on    :date
#  renewal_due_on            :date
#  registered_agents         :string(255)
#  raw_data                  :text
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#

