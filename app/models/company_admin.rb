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

# This is the Service Provider Admin role. Ability to add/remove users to the company, edit user
# profile info, etc., in addition to entering company details.
#
class CompanyAdmin < User
  validates_presence_of :company, if: proc { |user| user.role.company_admin? } # this 'if' may seem unnecessary, but don't forget Administrator inherits from CompanyAdmin, and we don't want that validation to apply to that model.
end



