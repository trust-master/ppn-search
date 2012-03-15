class DiscountType < ActiveRecord::Base
  has_many :discounts

  attr_accessible :name, as: [:default, :admin]
end


# == Schema Information
#
# Table name: discount_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

