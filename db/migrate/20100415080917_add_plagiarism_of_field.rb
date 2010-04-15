class AddPlagiarismOfField < ActiveRecord::Migration
  def self.up
    add_column :tweets, :plagiarism_of, :integer
  end

  def self.down
    remove_column :tweets, :plagiarism_of
  end
end
