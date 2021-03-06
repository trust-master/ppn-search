# == Schema Information
#
# Table name: personal_licenses
#
#  id                   :integer          not null, primary key
#  company_id           :integer
#  issuing_state_id     :integer
#  type_id              :integer
#  status_id            :integer
#  number               :string(255)
#  application_number   :string(255)
#  continuing_education :string(255)
#  enforcement_action   :boolean          default(FALSE), not null
#  name                 :string(255)
#  address              :text
#  phone_number         :string(255)
#  issued_on            :date
#  expires_on           :date
#  printed_on           :date
#  effective_on         :date
#  raw_data             :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fetched_at           :datetime
#

class PersonalLicense < ActiveRecord::Base
  include Fetchable
  extend EasyArelAccess

  belongs_to :type, class_name: 'LicenseType'
  belongs_to :status, class_name: 'LicenseStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company, touch: true

  serialize :raw_data, Hash

  validates :number, :application_number, :continuing_education, :name, :phone_number,
    length: { maximum: 255 }, allow_blank: true
  validates :number, presence: true, uniqueness: { scope: :issuing_state_id }
  validates :issuing_state, :company, presence: true

  attr_accessible :issuing_state_id, :number, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id, :number, :issuing_state_id

  scope :outdated, proc { where(t[:fetched_at].lt(24.hours.ago)) }

  def display_identifier
    [
      issuing_state.name,
      self.fetched? ? type.name : nil,
      number
    ].compact.join(' - ')
  end
end
