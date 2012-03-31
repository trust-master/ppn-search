class User < ActiveRecord::Base
  ROLES = %w[Administrator CompanyAdmin User].freeze
  self.inheritance_column = :role

  belongs_to :company
  belongs_to :created_by_user, class_name: 'User'
  belongs_to :updated_by_user, class_name: 'User'
  has_many :auth_tokens, class_name: 'UserAuthToken'
  has_many :password_resets

  before_save { |u| u.updated_by_user = self.class.current_user }
  before_create { |u| u.created_by_user = self.class.current_user }

  has_secure_password

  validates             :role, inclusion: { in: ROLES }, allow_blank: false
  validates             :email, presence: true, uniqueness: true, email: true
  validates_presence_of :first_name, :last_name
  validates_presence_of :password, :password_confirmation, on: :create
  validates             :password, password: true, allow_nil: true
  validates_presence_of :company, unless: proc { |user| user.is_a?(Administrator) }

  attr_accessible :first_name, :middle_name, :last_name, :email, :password, :password_confirmation, as: [:default, :admin]
  attr_accessible :role, :company_id, :active, as: [:admin]

  delegate :name, to: :company, prefix: true

  default_scope includes(:company)
  scope :sort_by_name_asc, order('last_name ASC, first_name ASC')
  scope :sort_by_name_desc, order('last_name DESC, first_name DESC')

  # wrapper for StringInquirer
  def role
    @role ||= UserRole.new(read_attribute(:role))
  end

  # helper for easily concatenating a user's names
  def display_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  class << self
    # method used for authentication
    def find_by_email_and_password(email, password)
      user = self.where(email: email).first
      if user and user.authenticate(password)
        user.touch :logged_in_at
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

