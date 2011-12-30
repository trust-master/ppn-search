# This is the Trust Master Admin user role. Supreme power, and stuff...
#
class Admin < CompanyAdmin
end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  active             :boolean         default(FALSE)
#  company_id         :integer
#  email              :string(255)
#  password_digest    :string(255)
#  first_name         :string(255)
#  middle_name        :string(255)
#  last_name          :string(255)
#  created_by_user_id :integer
#  updated_by_user_id :integer
#  role               :string(255)     default("User")
#  logged_in_at       :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

