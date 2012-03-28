require 'faker'

FactoryGirl.define do
  # This will guess the User class
  factory :company do
    name { Faker::Company.name }
    active true
    visible true
  end

end
