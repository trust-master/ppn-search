ActionMailer::Base.default({
  from: 'trust-master@rtlong.com'
})

# This interceptor will redirect outgoing emails to the trust-master Tgethr group,
# in the staging environment only, so we don't accidentally send an email to a customer
class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    message.to = 'trust-master@rtlong.com'
  end
end

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.staging?
