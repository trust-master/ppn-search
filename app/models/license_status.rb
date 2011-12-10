# == Schema Information
#
# Table name: license_status
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LicenseStatus < ActiveRecord::Base
  set_table_name :license_status # b/c AR doesn't listen to AS::Inflections :-(
  has_many :business_licenses
  has_many :personal_licenses
end
