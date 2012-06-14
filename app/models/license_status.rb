class LicenseStatus < ActiveRecord::Base
  has_many :business_licenses, foreign_key: :status_id
  has_many :personal_licenses, foreign_key: :status_id
  validates :name, length: { maximum: 255 }, presence: true
end




# == Schema Information
#
# Table name: license_statuses
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

