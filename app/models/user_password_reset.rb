class UserPasswordReset < ActiveRecord::Base
  belongs_to :user
end


# == Schema Information
#
# Table name: user_password_resets
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  token           :string(255)
#  requested_by_ip :string(255)
#  email_sent_at   :datetime
#  expires_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

