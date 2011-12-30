class Discount < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, :class_name => 'DiscountType'
  belongs_to :market

  validates_presence_of :type_id, :title, :start_date, :end_date
end

