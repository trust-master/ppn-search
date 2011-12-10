# == Schema Information
#
# Table name: service_areas
#
#  id         :integer         not null, primary key
#  market_id  :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ServiceArea < ActiveRecord::Base
  belongs_to :market
  has_many :company_service_areas
  has_many :companies, :through => :company_service_areas
end
