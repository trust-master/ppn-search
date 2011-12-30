class Location < ActiveRecord::Base
  belongs_to :company
  belongs_to :state
  belongs_to :country
end

