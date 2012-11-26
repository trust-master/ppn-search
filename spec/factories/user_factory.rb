# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  active             :boolean          default(FALSE), not null
#  company_id         :integer
#  email              :string(255)
#  password_digest    :string(255)
#  first_name         :string(255)
#  middle_name        :string(255)
#  last_name          :string(255)
#  created_by_user_id :integer
#  updated_by_user_id :integer
#  role               :string(255)      default("User")
#  logged_in_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  phone              :string(255)
#

require 'faker'
require Rails.root.join('lib','monkey_patches.rb')

FactoryGirl.define do
  # This will guess the User class
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{[first_name, last_name].join('.')}@Trust-Master.com" }
    password 'test123!'
    password_confirmation { password }
    company
  end
end
