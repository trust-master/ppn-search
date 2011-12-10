# == Schema Information
#
# Table name: discount_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class DiscountType < ActiveRecord::Base
  has_many :discounts
end
