# == Schema Information
#
# Table name: discount_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sort_order :integer          default(0), not null
#

class DiscountType < ActiveRecord::Base
  # default_scope order('sort_order DESC', :id)

  has_many :discounts, foreign_key: :type_id, dependent: :destroy
  has_many :companies, :through => :discounts

  attr_accessible :name, :sort_order, as: :administrator

  validates :sort_order, presence: true
  validates :name, length: { maximum: 255 }, presence: true
end



