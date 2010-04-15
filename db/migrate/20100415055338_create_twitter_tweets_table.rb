class CreateTwitterTweetsTable < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      # Foreign keys
      t.integer :user_id
      t.integer :detection_id
      
      # Fields
      t.string :text
      t.string :author
      t.string :twitter_id
      t.timestamp :tweeted_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end