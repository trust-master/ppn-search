class Session < FauxModel
  attr_accessor :email, :password

  validates :email, :password, :presence => true
  validates :email, :email => true

  self.types = {
    email: :string,
    password: :password
  }

end
