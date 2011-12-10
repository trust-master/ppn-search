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

class Association < ActiveRecord::Base
  belongs_to :company
end
