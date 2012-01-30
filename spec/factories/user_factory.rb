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

  # # This will use the User class (Admin would have been guessed)
  # factory :admin do
  #   first_name 'Admin'
  #   last_name  'User'
  # end

  # # The same, but using a string instead of class constant
  # factory :company_admin do
  #   first_name 'Admin'
  #   last_name  'User'
  # end
end
