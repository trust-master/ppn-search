class Affiliation < ActiveRecord::Base
  belongs_to :company
end


# == Schema Information
#
# Table name: affiliations
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

