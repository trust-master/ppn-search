
class PersonalLicenseType < LicenseType
  has_many :personal_licenses

  attr_accessible :name, :state_id, as: :admin
end
# == Schema Information
#
# Table name: license_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#  state_id   :integer
#

