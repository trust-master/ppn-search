# UserAuthToken model is responsible for auth tokens which will be mailed to new user in the case of
# a newly created user and/or a password reset. Creating a new UserAuthToken should generate a new
# token at the same time. This token should be unique in the table context, and it should include a
# random component as well as a component representing the `User.id`. The user-specific component
# MAY (it shouldn't need to, but it's likely) allow one to deduce to which user a given token
# belongs, but as such a token will be embedded in a hyperlink, which, when clicked, will
# authenticate the browser as the user in question, that seems to be a moot security issue. In this
# way, since the token is generated using the User's ID, the token will always be scoped to that
# User. Thus, even if the table of tokens is lost, there well never be a possibility of an old token
# being generated for a different User.
class UserAuthToken < ActiveRecord::Base
  belongs_to :user

  before_validation :token, :set_expiration

  # Do not allow a record to change these columns after creation
  attr_readonly :token, :user_id, :created_by_ip
  attr_accessible :created_by_ip

  validates :token, presence: true, uniqueness: true
  validates :user, presence: true #, associated: true
  validates_presence_of :created_by_ip
  validates :fullfilled_by_ip, :created_by_ip, ip_address: true, allow_nil: true
  validates :expires_at, presence: true

  # This method generates the token. It packs the user ID (as an unsigned 32-bit integer) and a
  # random 32-bit integer into a string then, since this is only an 8-byte string, and we want a
  # length which is divisible by 3, for Base64, it adds a random byte to the end. (During an unpack,
  # this remaining byte will simply be ignored.) Finally, URL-safe-Base64-encode the string and set
  # that to the column. It also ensures that no record currently exists with that token, before it
  # saves.
  def token
    return self[:token] if self[:token] # <- Will not generate a token more than once.
    begin
      byte_string = [self.user_id, rand(2**32)].pack('L*') << rand(256)
      self[:token] = Base64.urlsafe_encode64(byte_string)
    end while UserAuthToken.exists?(token: self[:token])
  end

  def fullfill!(ip_address)
    self[:fullfilled_by_ip] = ip_address
    self[:fullfilled_at] = Time.zone.now
    save!
  end

  def set_expiration
    self[:expires_at] = 3.hours.from_now
  end

  def expired?
    self[:expires_at] < Time.zone.now
  end

  def fullfilled?
    !! self[:fullfilled_at]
  end

  def inactive?
    fullfilled? or expired?
  end

  def active?
    not inactive?
  end

  def to_param
    token
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

