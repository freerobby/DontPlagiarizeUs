class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :detection
  
  validates_uniqueness_of :twitter_id, :scope => [:user_id, :detection_id]
  
  def is_original?
    author == nil
  end
  def is_fraud?
    author != nil
  end
end