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

class LicenseType < ActiveRecord::Base
  belongs_to :state

  validates :name, length: { maximum: 255 }, presence: true
end


