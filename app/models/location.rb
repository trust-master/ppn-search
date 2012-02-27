class Location < ActiveRecord::Base
  belongs_to :company
  belongs_to :state
  belongs_to :country

  def state_id=(id)
    write_attribute(:state_id, id)
    write_attribute(:country_id, State.find(id).country_id)
  end
end


# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  company_id :integer
#  city       :string(255)
#  state_id   :integer
#  zip        :string(255)
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

