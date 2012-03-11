class BusinessLicense < ActiveRecord::Base
  include Fetchable

  belongs_to :type,          class_name: 'LicenseType'
  belongs_to :status,        class_name: 'LicenseStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company

  serialize :raw_data, Hash

  validates :number, presence: true
  validates :issuing_state, :company, associated: true, presence: true

end


# == Schema Information
#
# Table name: business_licenses
#
#  id                                :integer         not null, primary key
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
#  enforcement_action                :boolean         default(FALSE)
#  name                              :string(255)
#  doing_business_as                 :string(255)
#  address                           :text
#  phone_number                      :string(255)
#  responsible_person_license_number :string(255)
#  raw_data                          :text
#  created_at                        :datetime        not null
#  updated_at                        :datetime        not null
#  fetched_at                        :datetime
#

