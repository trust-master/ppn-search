# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  email_address :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_by    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  first_name    :string(255)
#  last_name     :string(255)
#  updated_by    :string(255)
#  is_admin      :boolean
#

class User < ActiveRecord::Base
  belongs_to :company
  belongs_to :created_by_user, :class_name => User
  belongs_to :updated_by_user, :class_name => User

  validates_length_of :email_address, within: 3..40

  validates_uniqueness_of :email_address
  validates_format_of :email_address, with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, message: "Invalid email"

  attr_protected :id, :password_salt
  attr_accessor :change_password, :password, :password_confirm

  def password=(pass)
    if self.change_password
      @password=pass
      self.password_salt = User.random_string(10)
      self.password_hash = User.encrypt(@password, self.password_salt)
    end
  end
  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end
  def self.authenticate(email_address, pass)
    u=find(:first, :conditions=>["email_address = ?", email_address])
    return nil if u.nil?
    return u if User.encrypt(pass, u.password_salt)==u.password_hash
    nil
  end
  def self.encrypt(pass, salt)
    raise "Password was nil" if pass.nil?
    raise "Salt was nil" if salt.nil?
    Digest::SHA1.hexdigest(pass+salt)
  end
  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
end
