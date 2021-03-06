# == Schema Information
#
# Table name: business_filings
#
#  id                        :integer          not null, primary key
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
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  fetched_at                :datetime
#

class BusinessFiling < ActiveRecord::Base
  include Fetchable
  extend EasyArelAccess

  belongs_to :type,          class_name: 'FilingType'
  belongs_to :status,        class_name: 'FilingStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company, touch: true

  serialize :raw_data, Hash

  validates :number, :name, :home_jurisdiction, :registered_agents, length: { maximum: 255 }, allow_blank: true
  validates :number, presence: true, uniqueness: { scope: :issuing_state_id }
  validates :issuing_state, :company, presence: true
  validates :company_id, uniqueness: true

  attr_accessible :issuing_state_id, :number, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id, :number, :issuing_state_id

  normalize_attributes :number

  scope :outdated, proc { where(t[:fetched_at].lt(24.hours.ago)) }

  after_save do
    self.company.save # to set the active bit if necessary
  end

  def display_identifier
    [
      issuing_state.name,
      self.fetched? ? type.name : nil,
      number
    ].compact.join(' - ')
  end

end






