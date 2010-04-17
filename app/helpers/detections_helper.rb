module DetectionsHelper
  def display_key
    html = '<p>Original content is displayed in <font color="green">green</font>.<br />Direct plagiarism is displayed in <font color="red">red</font>.<br />Indirect plagiarism, or "fuzzy copying" is displayed in <font color="orange">orange</font>.</p>'
  end
  
  def display_plagiarized_tweet(tweet)
    html = "<b>" + link_to_twitter_handle(tweet.detection.screen_name) + "</b>: <font color=\"green\">#{tweet.text}</font> ["
    html += link_to("link", "http://twitter.com/#{tweet.detection.screen_name}/status/#{tweet.twitter_id}")
    html += "]<br />"
    html
  end
  
  def display_plagiarism_tweet(tweet)
    plagiarism_text = tweet.text
    if tweet.plagiarism_verbatim
      plagiarism_text.insert(tweet.plagiarism_ends_at, "</font>")
      plagiarism_text.insert(tweet.plagiarism_begins_at, "<font color=\"red\">")
    elsif !tweet.plagiarism_of.nil?
      plagiarism_text.insert(0, "<font color=\"orange\">")
      plagiarism_text.insert(plagiarism_text.length, "</font>")
    end
    
    html = "<b>" + link_to_twitter_handle(tweet.author) + "</b>: #{plagiarism_text} ["
    html += link_to("link", "http://twitter.com/#{tweet.author}/status/#{tweet.twitter_id}")
    html += "]<br />"
    html
  end
end
