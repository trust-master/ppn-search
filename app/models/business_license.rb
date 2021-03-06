# == Schema Information
#
# Table name: business_licenses
#
#  id                                :integer          not null, primary key
#  company_id                        :integer
#  issuing_state_id                  :integer
#  type_id                           :integer
#  status_id                         :integer
#  number                            :string(255)
#  application_number                :string(255)
#  expires_on                        :date
#  effective_on                      :date
#  issued_on                         :date
#  printed_on                        :date
#  enforcement_action                :boolean          default(FALSE), not null
#  name                              :string(255)
#  doing_business_as                 :string(255)
#  address                           :text
#  phone_number                      :string(255)
#  responsible_person_license_number :string(255)
#  raw_data                          :text
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  fetched_at                        :datetime
#

class BusinessLicense < ActiveRecord::Base
  include Fetchable
  extend EasyArelAccess

  belongs_to :type,          class_name: 'LicenseType'
  belongs_to :status,        class_name: 'LicenseStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company, touch: true

  serialize :raw_data, Hash

  validates :number, :name, :application_number, :doing_business_as, :phone_number,
    :responsible_person_license_number, length: { maximum: 255 }, allow_blank: true
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
