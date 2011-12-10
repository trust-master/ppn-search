class LicenseType < ActiveRecord::Base
  has_many :business_licenses
  has_many :personal_licenses
end
