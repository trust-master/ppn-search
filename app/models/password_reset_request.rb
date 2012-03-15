class PasswordResetRequest < FauxModel
  attr_accessor :email, :name

  validates :email, :name, presence: true

  self.types = { email: :string, name: :string }
end