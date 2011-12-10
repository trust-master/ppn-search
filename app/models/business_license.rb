# == Schema Information
#
# Table name: business_certificates
#
#  id                                :integer         not null, primary key
#  name                              :string(255)
#  business_as                       :string(255)
#  address                           :string(255)
#  city_state_zip                    :string(255)
#  license_number                    :string(255)
#  license_type                      :string(255)
#  company_structure                 :string(255)
#  status                            :string(255)
#  original_issue_date               :date
#  expiration_date                   :date
#  print_date                        :date
#  responsible_person_name           :string(255)
#  responsible_person_license_number :string(255)
#  contractors_phone_number          :string(255)
#  enforcement_action                :string(255)
#  created_at                        :datetime
#  updated_at                        :datetime
#  company_id                        :integer
#

class BusinessLicense < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => LicenseType
  belongs_to :status, :class_name => LicenseStatus
end
