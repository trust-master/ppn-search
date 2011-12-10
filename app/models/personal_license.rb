# == Schema Information
#
# Table name: personal_certificates
#
#  id                   :integer         not null, primary key
#  company_id           :integer
#  name                 :string(255)
#  status               :string(255)
#  print_date           :date
#  continuing_education :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  certificate_type     :string(255)
#  address              :string(255)
#

class PersonalLicense < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => LicenseType
  belongs_to :status, :class_name => LicenseStatus
end
