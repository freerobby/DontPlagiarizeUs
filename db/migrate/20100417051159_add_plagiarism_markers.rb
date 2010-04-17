class AddPlagiarismMarkers < ActiveRecord::Migration
  def self.up
    add_column :tweets, :plagiarism_verbatim, :boolean, :default => false
    add_column :tweets, :plagiarism_begins_at, :integer
    add_column :tweets, :plagiarism_ends_at, :integer
    
    Tweet.plagiarism_of_not_null.each do |tweet|
      tweet.send :analyze_plagiarism
    end
  end

  def self.down
    remove_column :tweets, :plagiarism_ends_at
    remove_column :tweets, :plagiarism_begins_at
    remove_column :tweets, :plagiarism_verbatim
  end
end
