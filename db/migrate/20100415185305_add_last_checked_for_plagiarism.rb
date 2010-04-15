class AddLastCheckedForPlagiarism < ActiveRecord::Migration
  def self.up
    add_column :tweets, :last_checked_if_plagiarized, :datetime
  end

  def self.down
    remove_column :tweets, :last_checked_if_plagiarized, :datetime
  end
end
