class RemoveLastTweetTwitterIdFromDetections < ActiveRecord::Migration
  def self.up
    remove_column :detections, :last_tweet_twitter_id
  end

  def self.down
    add_column :detections, :last_tweet_twitter_id, :bigint, :default => 0
  end
end
