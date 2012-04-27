module TimeAgoHelper

  def time_ago_in_words(time)
    content_tag(:time, time.to_s, datetime: time.getutc.iso8601, class: 'timeago')
  end

end