class ServiceArea < ActiveRecord::Base
  # default_scope order('service_areas.sort_order DESC', :id)

  belongs_to :market, inverse_of: :service_areas
  has_many :company_service_areas, dependent: :destroy
  has_many :companies, through: :company_service_areas

  attr_accessible :name, :market_id, :sort_order, as: :administrator

  validates_presence_of :name, :market
end




# == Schema Information
#
# Table name: service_areas
#
#  id         :integer         not null, primary key
#  market_id  :integer
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  sort_order :integer         default(0), not null
#

