class Market < ActiveRecord::Base
  default_scope order('sort_order DESC', :id)

  has_many :service_areas, inverse_of: :market,         dependent: :destroy
  has_many :discounts,             dependent: :nullify
  has_many :company_service_areas, through: :service_areas
  has_many :companies,             through: :company_service_areas

  accepts_nested_attributes_for :service_areas, allow_destroy: true

  attr_accessible :name, :service_areas_attributes, :sort_order, as: :admin

  validates_presence_of :name
end



# == Schema Information
#
# Table name: markets
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  sort_order :integer         default(0), not null
#

