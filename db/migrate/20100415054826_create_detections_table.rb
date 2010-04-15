class CreateDetectionsTable < ActiveRecord::Migration
  def self.up
    create_table :detections do |t|
      t.integer :user_id, :null => false
      t.bigint :last_tweet_twitter_id, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :detections
  end
end
