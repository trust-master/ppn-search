class DiscountType < ActiveRecord::Base
  default_scope order('sort_order DESC', :id)

  has_many :discounts

  attr_accessible :name, :sort_order, as: :admin
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

