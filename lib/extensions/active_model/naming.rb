module ActiveModel
  class Name < String
    def mailer_name
      '' << self << 'Mailer'
    end
  end
end