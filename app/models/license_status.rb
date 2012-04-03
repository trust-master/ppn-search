class LicenseStatus < ActiveRecord::Base
  self.table_name = :license_status # b/c AR doesn't listen to AS::Inflections :-(

  has_many :business_licenses, foreign_key: :status_id
  has_many :personal_licenses, foreign_key: :status_id
end



# == Schema Information
#
# Table name: license_status
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

