# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sort_order :integer          default(0), not null
#

class Market < ActiveRecord::Base
  # default_scope order('markets.sort_order DESC', :id)

  has_many :service_areas,         dependent: :destroy, inverse_of: :market
  has_many :discounts,             dependent: :nullify
  has_many :company_service_areas, through: :service_areas
  has_many :companies,             through: :company_service_areas

  accepts_nested_attributes_for :service_areas, allow_destroy: true

  attr_accessible :name, :service_areas_attributes, :sort_order, as: :administrator

  validates :name, length: { maximum: 255 }, presence: true
  validates :sort_order, presence: true
end
