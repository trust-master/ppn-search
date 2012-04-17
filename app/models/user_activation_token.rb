class UserActivationToken < UserAuthToken
  def mailer
    UserMailer.welcome(self)
  end
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
#  expires_at       :datetime        not null
#  created_at       :datetime        not null
#  created_by_ip    :string(255)
#  updated_at       :datetime        not null
#

