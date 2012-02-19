class PersonalLicense < ActiveRecord::Base
  belongs_to :type, :class_name => 'LicenseType'
  belongs_to :status, :class_name => 'LicenseStatus'
  belongs_to :issuing_state, class_name: 'State'
  belongs_to :company

  serialize :raw_data, Hash
end



# == Schema Information
#
# Table name: personal_licenses
#
#  id                   :integer         not null, primary key
#  company_id           :integer
#  issuing_state_id     :integer
#  type_id              :integer
#  status_id            :integer
#  number               :string(255)
#  application_number   :string(255)
#  continuing_education :string(255)
#  enforcement_action   :boolean         default(FALSE)
#  name                 :string(255)
#  address              :text
#  issued_on            :date
#  expires_on           :date
#  printed_on           :date
#  effective_on         :date
#  raw_data             :text
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

