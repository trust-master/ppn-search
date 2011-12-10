# == Schema Information
#
# Table name: associations
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
#  company_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Association < ActiveRecord::Base
  belongs_to :company
end
