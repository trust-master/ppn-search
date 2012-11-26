# == Schema Information
#
# Table name: companies
#
#  id                                 :integer          not null, primary key
#  active                             :boolean          default(FALSE), not null
#  visible                            :boolean          default(FALSE), not null
#  deleted_at                         :datetime
#  deleted_by_user_id                 :integer
#  name                               :string(255)
#  email                              :string(255)
#  phone_main                         :string(255)
#  phone_mobile                       :string(255)
#  phone_fax                          :string(255)
#  website_url                        :string(255)
#  in_business_since                  :date
#  about                              :string(255)
#  benefits                           :text
#  specialty                          :text
#  offers_24_hour_service             :boolean          default(FALSE), not null
#  offers_emergency_service           :boolean          default(FALSE), not null
#  insured                            :boolean          default(FALSE), not null
#  insurance_state_id                 :integer
#  insurance_valid_from               :date
#  insurance_valid_until              :date
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  insurance_certificate_file_name    :string(255)
#  insurance_certificate_content_type :string(255)
#  insurance_certificate_file_size    :integer
#  insurance_certificate_updated_at   :datetime
#  insurance_certificate_fingerprint  :string(255)
#  insurance_certificate_meta         :text
#  description                        :text
#

require 'faker'

FactoryGirl.define do
  # This will guess the User class
  factory :company do
    name { Faker::Company.name }
    active true
    visible true
  end

end
