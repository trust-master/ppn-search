class State < ActiveRecord::Base
  belongs_to :country
  has_many :locations
end




# == Schema Information
#
# Table name: states
#
#  id           :integer         not null, primary key
#  country_id   :integer
#  name         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  abbreviation :string(255)     not null
#

