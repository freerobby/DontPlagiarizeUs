class Detection < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 15
  
  has_many :tweets, :order => "plagiarism_verbatim DESC, tweeted_at DESC"
  
  validates_uniqueness_of :screen_name
  validates_presence_of :screen_name
  
  # This is a hacky named_scope. We rely on plagiarism_begins_at being null or not to represent plagiarism_verbatim being true or false. We need to do this because SQLite doesn't play nicely with boolean data types, and Rails doesn't support introspection on the "ORDER" clause.
  named_scope :most_plagiarized, :select => 'detections.*', :order => "(SELECT COUNT(*) FROM tweets WHERE detections.id=detection_id AND plagiarism_of IS NOT NULL AND plagiarism_begins_at IS NOT NULL) DESC, (SELECT COUNT(*) FROM tweets WHERE detections.id=detection_id AND plagiarism_of IS NOT NULL AND plagiarism_begins_at IS NULL) DESC"
  
  def to_param
    screen_name
  end
  
  def update_earlier!
    get_earlier_tweets
    search_for_plagiarism
    true
  end
  
  def update_later!
    get_latest_tweets
    search_for_plagiarism
    true
  end
  
  private
  def get_twitter_client
    oauth = Twitter::OAuth.new(::TWITTER_CONSUMER_KEY, ::TWITTER_CONSUMER_SECRET)
    Twitter::Base.new(oauth)
  end
  
  def get_earlier_tweets
    client = get_twitter_client
    max_id = (tweets.size == 0) ? 1 : tweets.ascend_by_twitter_id.first.twitter_id
    timeline = client.user_timeline(:max_id => max_id, :count => ::MINED_TWEETS_PER_SEARCH_QUERY, :screen_name => screen_name)
    puts "Found #{timeline.size} older tweets."
    timeline.each do |tweet|
      t = Tweet.create :detection => self, :text => tweet.text, :twitter_id => tweet.id, :tweeted_at => tweet.created_at
      puts "Added tweet: #{t.text}"
    end
  end
  
  def get_latest_tweets
    client = get_twitter_client
    since_id = (tweets.size == 0) ? 1 : tweets.descend_by_twitter_id.first.twitter_id
    timeline = client.user_timeline(:since_id => since_id, :count => ::MINED_TWEETS_PER_SEARCH_QUERY, :screen_name => screen_name)
    puts "Found #{timeline.size} recent tweets."
    timeline.each do |tweet|
      t = Tweet.create :detection => self, :text => tweet.text, :twitter_id => tweet.id, :tweeted_at => tweet.created_at
      puts "Added tweet: #{t.text}"
    end
  end
  
  def search_for_plagiarism
    Tweet.detection_id_eq(id).each do |tweet|
      if tweet.meets_prerequisites? && (tweet.last_checked_if_plagiarized.nil? || Time.now > tweet.last_checked_if_plagiarized + 24.hours)
        query = '"' + tweet.text + '"' + ' -RT -via' + " -#{screen_name}"
        results = Twitter::Search.new(query).fetch().results
        tweet.update_attribute :last_checked_if_plagiarized, Time.now
        results = [] if results.nil?
      
        results.each do |result|
          if Time.parse(result.created_at) >= tweet.tweeted_at && Tweet.find_by_twitter_id(tweet.id).nil? && result.from_user.downcase != screen_name.downcase
            puts "Plagiarism found for Tweet #{tweet.id}"
            Tweet.create :detection => self, :text => result.text, :twitter_id => result.id, :tweeted_at => result.created_at, :author => result.from_user, :plagiarism_of => tweet.id
          end
        end
      else
        # puts "Skipping plagiarism search for: #{tweet.text} (less than 24 hours since last search)"
      end
    end
  end
end