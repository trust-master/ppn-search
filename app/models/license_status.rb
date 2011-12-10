class LicenseStatus < ActiveRecord::Base
  set_table_name :license_status # b/c AR doesn't listen to AS::Inflections :-(
  has_many :business_licenses
  has_many :personal_licenses
end
