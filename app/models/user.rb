class User < ActiveRecord::Base
  ROLES = %w[CompanyAdmin User].freeze
  PROTECTED_ROLES = (%w[Administrator] | ROLES).freeze
  self.inheritance_column = :role

  has_paper_trail

  belongs_to :company
  has_many :auth_tokens, class_name: 'UserAuthToken', order: 'user_auth_tokens.created_at DESC'
  has_many :password_resets

  attr_accessible :first_name, :middle_name, :last_name, :email, :phone, :password, :password_confirmation,
    as: [:user, :administrator, :company_admin]
  attr_accessible :role, :active, as: [:administrator, :company_admin]
  attr_accessible :company_id, as: :administrator

  include ActiveModel::Validations
  validates_with         RoleValidator
  validates :email, :password_digest, :first_name, :middle_name, :last_name, :role, :phone,
    length: { maximum: 255 }, allow_blank: true

  validates :email, presence: true, uniqueness: true, email: true
  validates_presence_of  :first_name, :last_name, :role
  validates_inclusion_of :active, in: [true, false]

  has_secure_password
  validates              :password, password: true, allow_nil: true # allow_blank only for pre-activation circumstances

  # default_scope includes(:company)
  scope :sort_by_name_asc,  order('last_name ASC, first_name ASC')
  scope :sort_by_name_desc, order('last_name DESC, first_name DESC')

  delegate :name, to: :company, prefix: true

  # helper for easily concatenating a user's names
  def display_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def reset_password!
    self.password_resets.create!
  end

  # wrapper for StringInquirer
  def role
    @role ||= self[:role] && UserRole.new(self[:role])
  end

  # The following fix problems I was seeing where AR was calling #type= on this class, even though
  # the inheritance column is set, above.
  def type
    self[:role]
  end
  def type=(class_name)
    self[:role] = class_name
  end

  class << self
    # method used for authentication
    def find_by_email_and_password(email_address, password)
      user = self.where{ (password_digest != nil) & (email == email_address) }.first
      if user and user.authenticate(password)
        return user
      end
    end

    # used by `set_current_user_in_user_model` in ApplicationController
    def current_user=(user)
      @@current_user = user
    end
    def current_user
      @@current_user if defined? @@current_user
    end
  end
end





# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  active             :boolean         default(FALSE), not null
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
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  phone              :string(255)
#

