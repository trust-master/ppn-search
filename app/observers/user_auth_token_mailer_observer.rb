class UserAuthTokenMailerObserver

  def self.delivered_email(message)
    token = message.instance_variable_get(:@token)
    token.touch(:email_sent_at)
  end

end