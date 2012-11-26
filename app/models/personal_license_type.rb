# == Schema Information
#
# Table name: license_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string(255)
#  state_id   :integer
#


class PersonalLicenseType < LicenseType
  has_many :personal_licenses

  attr_accessible :name, :state_id, as: :administrator
end
