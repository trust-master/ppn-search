class Association < ActiveRecord::Base
  belongs_to :company

  validates :url, url: true
  validates :name, presence: true

  attr_accessible :name, :title, :description, :started_on, :ended_on, :url, as: [:default, :admin]
  attr_readonly :company_id
end


# == Schema Information
#
# Table name: associations
#
#  id          :integer         not null, primary key
#  company_id  :integer
#  name        :string(255)
#  title       :string(255)
#  description :text
#  started_on  :date
#  ended_on    :date
#  url         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

