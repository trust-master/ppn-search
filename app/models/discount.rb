class Discount < ActiveRecord::Base
  belongs_to :company
  belongs_to :type, class_name: 'DiscountType'
  belongs_to :market

  validates_presence_of :type_id, :title, :start_date, :end_date

  mount_uploader :image, CertificateUploader

  attr_accessible :type_id, :title, :description, :image, :image_cache, :remove_image,
    :market_id, :start_date, :end_date, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id

  delegate :name, to: :type, prefix: true
end




# == Schema Information
#
# Table name: discounts
#
#  id          :integer         not null, primary key
#  company_id  :integer
#  type_id     :integer
#  title       :string(255)
#  description :text
#  image       :string(255)
#  market_id   :integer
#  start_date  :date
#  end_date    :date
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

