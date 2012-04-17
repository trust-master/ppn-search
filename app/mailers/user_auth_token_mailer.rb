class UserAuthTokenMailer < ApplicationMailer

  # def initialize(token)
  #   @token = token
  # end

  # def password_reset
  #   @link = password_reset_url(@token)
  #   mail(to: @to)
  # end

  # def user_activation_token
  #   @link = activate_url(token)
  #   mail(to: @to)
  # end

  # def user_reactivation_token
  #   @link = activate_url(token)
  #   mail(to: @to)
  # end

  private

  # returns the arguments needed to be sent to self.perform, so we can expose a uniform API for all
  # mailers. These should be the types of arguments that Resque can handle (simple types)
  def args_for_perform
    [@token.id]
  end

  class << self
    def self.perform(token_id)
    end
  end
end
