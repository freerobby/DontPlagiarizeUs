class RequireScreenName < ActiveRecord::Migration
  def self.up
    change_column :detections, :screen_name, :string, :null => false
  end

  def self.down
    change_column :detections, :screen_name, :string
  end
end
