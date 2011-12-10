# == Schema Information
#
# Table name: business_licenses
#
#  id                                :integer         not null, primary key
#  company_id                        :integer
#  type_id                           :integer
#  status_id                         :integer
#  number                            :string(255)
#  name                              :string(255)
#  doing_business_as                 :string(255)
#  address                           :string(255)
#  address2                          :string(255)
#  city                              :string(255)
#  state                             :string(255)
#  zip                               :string(255)
#  company_structure                 :string(255)
#  issued_on                         :date
#  expires_on                        :date
#  printed_on                        :date
#  enforcement_action                :boolean         default(FALSE)
#  responsible_person_name           :string(255)
#  responsible_person_license_number :string(255)
#  contractors_phone_number          :string(255)
#  created_at                        :datetime
#  updated_at                        :datetime
#

class BusinessLicense < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => LicenseType
  belongs_to :status, :class_name => LicenseStatus
end
