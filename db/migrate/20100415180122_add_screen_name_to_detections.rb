class AddScreenNameToDetections < ActiveRecord::Migration
  def self.up
    add_column :detections, :screen_name, :string
  end

  def self.down
    remove_column :detections, :screen_name
  end
end
