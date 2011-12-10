# == Schema Information
#
# Table name: affiliations
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  title          :string(255)
#  current_member :boolean
#  start_month    :integer
#  start_year     :integer
#  end_month      :integer
#  end_year       :integer
#  uri            :string(255)
#  description    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  company_id     :integer
#

class Affiliation < ActiveRecord::Base
  belongs_to :company
end
