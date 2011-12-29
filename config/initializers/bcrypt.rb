require 'bcrypt'

if Rails.env.development? or Rails.env.test?
  silence_warnings do
    # Speed up BCrypt during development (especially useful when seeding the database)
    BCrypt::Engine::DEFAULT_COST = BCrypt::Engine::MIN_COST
  end
end