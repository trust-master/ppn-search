ActionMailer::Base.default({
  from: 'info@trust-master.com'
})

class PreventMailInterceptor
  ALLOWED_EMAILS = /@(?:rtlong|trust-master)\.com\z/
  DEFAULT_RECIPIENTS = ENV['EMAIL_INTERCEPTOR_DEFAULT_RECIPIENTS'].presence.try(:split, ?,) || %w[ ryan@rtlong.com dmodeen@trust-master.com ]

  def self.delivering_email(message)
    new(message).intercept
  end

  def initialize(message)
    @message = message
    @original_recipients = message.to
  end
  attr_reader :message, :original_recipients

  def intercept
    message.to = original_recipients.grep(ALLOWED_EMAILS).presence || DEFAULT_RECIPIENTS
    message.subject.prepend("[#{Rails.env.to_s}] ")
    notice = "[INTERCEPTED] Original recipients were: #{original_recipients.join(?;)}"
    message.body.parts.each do |part|
      case part.content_type
      when %r[^text/plain]
        part.body.raw_source << "\n\n--------\n#{notice}"
      when %r[^text/html]
        part.body.raw_source << "<p><hr/></p><p>#{notice}</p>".html_safe
      end
    end
  end

end

ActionMailer::Base.register_observer(UserAuthTokenMailerObserver)

ActionMailer::Base.register_interceptor(PreventMailInterceptor) if ENV['EMAIL_INTERCEPTOR_ENABLED']
