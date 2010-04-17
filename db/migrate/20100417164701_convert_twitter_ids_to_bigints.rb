class ConvertTwitterIdsToBigints < ActiveRecord::Migration
  def self.up
    add_column :tweets, :twitter_id_new, :bigint, :default => 0
    Tweet.all.each {|tweet| tweet.update_attribute :twitter_id_new, tweet.twitter_id.to_i}
    remove_column :tweets, :twitter_id
    rename_column :tweets, :twitter_id_new, :twitter_id
  end

  def self.down
    add_column :tweets, :twitter_id_new, :string
    Tweet.all.each {|tweet| tweet.update_attribute :twitter_id_new, tweet.twitter_id.to_s}
    remove_column :tweets, :twitter_id
    rename_column :tweets, :twitter_id_new, :twitter_id
  end
end