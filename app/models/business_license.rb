class BusinessLicense < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => 'LicenseType'
  belongs_to :status, :class_name => 'LicenseStatus'
end

