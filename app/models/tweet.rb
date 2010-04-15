class Tweet < ActiveRecord::Base
  belongs_to :detection
  
  validates_uniqueness_of :twitter_id, :scope => [:detection_id]
  
  def is_original?
    author == nil
  end
  def is_fraud?
    author != nil
  end
  
  def meets_prerequisites?
    return false if text.nil?
    return false if text.size < ::MINIMUM_LENGTH_FOR_PLAGIARISM
    return false if text.split(/ /).size < ::MINIMUM_WORDS_FOR_PLAGIARISM
    true
  end
end