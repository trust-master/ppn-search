class ServiceArea < ActiveRecord::Base
  default_scope order(:sort_order, :id)

  belongs_to :market
  has_many :company_service_areas, dependent: :destroy
  has_many :companies, through: :company_service_areas

  attr_accessible :name, :market_id, :sort_order, as: :admin

  validates :name, :market, presence: true
  validates_associated :market
end


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

