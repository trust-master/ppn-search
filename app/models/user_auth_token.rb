class UserAuthToken < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: user_auth_tokens
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  token            :string(255)
#  type             :string(255)
#  fullfilled_by_ip :string(255)
#  fullfilled_at    :datetime
#  email_sent_at    :datetime
#  expires_at       :datetime
#  created_at       :datetime
#  created_by_ip    :string(255)
#  updated_at       :datetime
#

