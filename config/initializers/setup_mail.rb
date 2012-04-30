ActionMailer::Base.default({
  from: 'info@trust-master.com'
})

ActionMailer::Base.register_observer(UserAuthTokenMailerObserver)