ActiveModel::Name.class_eval do
  def mailer_name
    '' << self << 'Mailer'
  end
end
