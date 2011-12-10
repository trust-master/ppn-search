# == Schema Information
#
# Table name: license_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LicenseType < ActiveRecord::Base
  has_many :business_licenses
  has_many :personal_licenses
end
