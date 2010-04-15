class CreateDetectionsTable < ActiveRecord::Migration
  def self.up
    create_table :detections do |t|
      t.integer :user_id, :null => false
      t.timestamps
    end
    add_column :detections, :last_tweet_twitter_id, :bigint, :null => false, :default => 0
  end

  def self.down
    drop_table :detections
  end
end
