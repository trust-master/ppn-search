class UserAuthTokenMailerObserver

  def self.delivered_email(message)
    if token = message.instance_variable_get(:@token)
      token.touch(:email_sent_at)
    end
  end

end