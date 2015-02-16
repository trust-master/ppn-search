require 'active_model/secure_password'

if Rails.env.development? or Rails.env.test?
  ActiveModel::SecurePassword.min_cost = true
end
