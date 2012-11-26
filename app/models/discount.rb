# == Schema Information
#
# Table name: discounts
#
#  id                      :integer          not null, primary key
#  company_id              :integer
#  type_id                 :integer
#  title                   :string(255)
#  description             :text
#  market_id               :integer
#  start_date              :date
#  end_date                :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  attachment_fingerprint  :string(255)
#  attachment_meta         :text
#

class Discount < ActiveRecord::Base
  belongs_to :company, touch: true
  belongs_to :type, class_name: 'DiscountType'
  belongs_to :market

  has_attached_file :attachment

  validates_presence_of :type_id, :title, :start_date, :end_date
  validates :title, length: { maximum: 255 }
  validates_attachment :attachment, size: { less_than_or_equal_to: 2.megabytes },
    content_type: {
      content_type: ValidationPatterns::AcceptableUploadTypes }

  attr_accessible :type_id, :title, :description, :attachment,
    :market_id, :start_date, :end_date, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id

  delegate :name, to: :type, prefix: true

  scope :not_expired, where('end_date >= ?', Date.today)

  before_post_process { !! ValidationPatterns::ImageContentTypes.match(attachment.content_type) }

end





