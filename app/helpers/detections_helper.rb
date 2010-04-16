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
  
  def display_plagiarism_tweet(tweet, plagiarized_tweet)
    plagiarized_text = plagiarized_tweet.text
    plagiarism_text = tweet.text
    start = plagiarism_text.downcase.index(plagiarized_text.downcase)
    finish = start + plagiarized_text.length unless start.nil?
    if !start.nil? && !finish.nil? 
      plagiarism_text.insert(finish, "</font>")
      plagiarism_text.insert(start, "<font color=\"red\">")
    else
      plagiarism_text.insert(0, "<font color=\"orange\">")
      plagiarism_text.insert(plagiarism_text.length, "</font>")
    end
    
    html = "<b>" + link_to_twitter_handle(tweet.author) + "</b>: #{plagiarism_text} ["
    html += link_to("link", "http://twitter.com/#{tweet.author}/status/#{tweet.twitter_id}")
    html += "]<br />"
    html
  end
end
