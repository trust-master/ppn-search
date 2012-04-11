module ActiveModel::SecurePassword
  module ClassMethods
    # This is being overridden, here, to avoid the validates_presence_of(:password_digest) that is
    # commented below. We need to be able to create users without having passwords, which can then
    # be 'activated' via email, at which time the user will set a password. This poses no security
    # threat, as the User#authenticate method will not work if the password_digest is nil.
    def has_secure_password
      # Load bcrypt-ruby only when has_secure_password is used.
      # This is to avoid ActiveModel (and by extension the entire framework) being dependent on a binary library.
      gem 'bcrypt-ruby', '~> 3.0.0'
      require 'bcrypt'

      attr_reader :password

      validates_confirmation_of :password
      # validates_presence_of   :password_digest

      include InstanceMethodsOnActivation

      if respond_to?(:attributes_protected_by_default)
        def self.attributes_protected_by_default
          super + ['password_digest']
        end
      end
    end
  end
end