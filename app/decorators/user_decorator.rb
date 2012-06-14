module UserDecorator

  def logged_in_at
    self[:logged_in_at] ? time_ago_in_words(self[:logged_in_at]) : 'never'
  end

end