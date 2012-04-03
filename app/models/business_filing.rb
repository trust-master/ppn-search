class BusinessFiling < ActiveRecord::Base
  include Fetchable

  belongs_to :type,          class_name: 'FilingType'
  belongs_to :status,        class_name: 'FilingStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company

  serialize :raw_data, Hash

  validates :number, presence: true
  validates :issuing_state, :company, presence: true

  attr_accessible :issuing_state_id, :number, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id, :number, :issuing_state_id

  def display_identifier
    [
      issuing_state.name,
      self.fetched? ? type.name : nil,
      number
    ].compact.join(' - ')
  end

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
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#  fetched_at                :datetime
#  raw_data                  :text
#

