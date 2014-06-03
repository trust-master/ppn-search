class AdminMailer < ActionMailer::Base
  layout 'admin_mailer'

  default from: 'PPN Search <info@trust-master.com>'

  def user_activated(token, opts = {})
    @token = token
    @user = token.user
    mail to: ['Dan Modeen <dmodeen@trust-master.com>']
  end

end
