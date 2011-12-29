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

# This is the Service Provider Admin role. Ability to add/remove users to the company, edit user
# profile info, etc., in addition to entering company details.
#
class CompanyAdmin < User
end
