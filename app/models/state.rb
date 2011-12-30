class State < ActiveRecord::Base
  belongs_to :country
  has_many :locations
end


# == Schema Information
#
# Table name: states
#
#  id         :integer         not null, primary key
#  country_id :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

