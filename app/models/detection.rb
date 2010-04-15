class Detection < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
  
  def update!
    get_latest_tweets
    search_for_plagiarism
    true
  end
  
  private
  def get_twitter_client
    oauth = Twitter::OAuth.new(TwitterAuth.config['oauth_consumer_key'], TwitterAuth.config['oauth_consumer_secret'])
    oauth.authorize_from_access(self.user.access_token, self.user.access_secret)
    Twitter::Base.new(oauth)
  end
  
  def get_latest_tweets
    client = get_twitter_client
    puts "last: #{last_tweet_twitter_id}"
    since_id = (last_tweet_twitter_id == 0) ? 1 : last_tweet_twitter_id
    timeline = client.user_timeline(:since_id => since_id, :count => 40)
    puts "Found #{timeline.size} recent tweets."
    timeline.each do |tweet|
      puts "Saving tweet #{tweet.id}"
      Tweet.create :user => user, :detection => self, :text => tweet.text, :twitter_id => tweet.id, :tweeted_at => tweet.created_at
    end
    
    self.update_attribute(:last_tweet_twitter_id, timeline.first.object_id) unless timeline.nil?
  end
  
  def search_for_plagiarism
    # client = get_twitter_client
    query = ""
    Tweet.user_id_eq(user.id).detection_id_eq(id).each do |tweet|
      query += '"' + tweet.text.gsub(/"/, "'") + '" OR '
    end
    query += '"zxvzxcvzxcvzxcvzxc"' + ' -RT -via' + " -#{user.login}"
    
    puts "QUERY: #{query}"
    
    results = Twitter::Search.new(query).fetch().results
    results = [] if results.nil?
      
    results.each do |result|
      puts "Plagiarism found: #{result.inspect}"
      tweet = Tweet.find_by_text(result.text)
      if Time.parse(result.created_at) >= tweet.tweeted_at
        Tweet.create :user => user, :detection => self, :text => result.text, :twitter_id => result.id, :tweeted_at => result.created_at, :author => result.from_user, :plagiarism_of => tweet.id
      end
    end
  end
end