# This is the abstract class to parent the mailers in the app. It functions as a wrapper around
# Mail, like ActionMailer would, but runs as a Resque job, and utilizes the EmailTemplate model to
# render it's templates
class ApplicationMailer
  def queue; :mails; end

  attr_accessor :template_id

  def template_id=(id)
    @template = nil # clear the cached template
    @template_id = id.to_s
  end

  # get the template for this mailer, and create a new one if not found.
  def template
    return nil if template_id.nil?
    @template ||= EmailTemplate.where(id: template_id).first_or_create! do |template|
      template.subject = "[PPN]: #{template_id.humanize} email"
      template.body    = <<-BODY.strip_heredoc
        Sample content for the [#{template_id}] email template. You can customize this template in
        the Admin interface. It is formatted with Markdown, and interpretted with Liquid, for the
        variables shown in the admin interface for this template.
      BODY
    end
  end

  # enqueue the message for delivery
  def deliver
    Resque.enqueue(self, *args_for_perform)
  end
  alias :enqueue_for_delivery :deliver

  def deliver!
    self.class.perform(*args_for_perform)
  end

  def template
    @template ||= begin
      template_id = self.class.name.sub(/Mailer\Z/, '')
      EmailTemplate.where(id: template_id).first_or_create! do |template|
        template.subject      = template.id.constantize.model_name.human
        template.body         = "Sample content for the [#{template_id}] email template"
        template.display_name = template.id.humanize
      end
    end
  end

  private

  # returns the arguments needed to be sent to self.perform, so we can expose a uniform API for all
  # mailers. These should be the types of arguments that Resque can handle (simple types)
  def args_for_perform
    [] # this should be overridden in subclasses to match the behavior present in the perform method
  end

  class << self
    def self.perform(*args)


    end
  end

  class GenericMailer < ActionMailer::Base
    def build(*args)
      puts "#{self.name}#build called with #{args.inspect}"

      mail(*args)
    end
  end


end