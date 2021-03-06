# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  active             :boolean          default(FALSE), not null
#  company_id         :integer
#  email              :string(255)
#  password_digest    :string(255)
#  first_name         :string(255)
#  middle_name        :string(255)
#  last_name          :string(255)
#  created_by_user_id :integer
#  updated_by_user_id :integer
#  role               :string(255)      default("User")
#  logged_in_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  phone              :string(255)
#

# This is the Trust Master Admin user role. Supreme power, and stuff...
#
class Administrator < CompanyAdmin
end



