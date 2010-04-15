class AllowNullUsers < ActiveRecord::Migration
  def self.up
    change_column :detections, :user_id, :integer, :null => true
  end

  def self.down
    change_column :detections, :user_id, :integer, :null => false
  end
end
