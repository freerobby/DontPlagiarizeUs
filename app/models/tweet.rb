class Tweet < ActiveRecord::Base
  belongs_to :detection
  validates_uniqueness_of :twitter_id, :scope => [:detection_id]
  validates_inclusion_of :plagiarism_verbatim, :in => [true, false]
  after_create :analyze_plagiarism
  
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
  
  private
  def analyze_plagiarism
    unless plagiarism_of.nil?
      original_text = Tweet.find(plagiarism_of).text
      
      start = text.downcase.index(original_text.downcase)
      finish = start + original_text.length unless start.nil?
      if !start.nil? && !finish.nil? && finish <= text.length
        update_attributes :plagiarism_verbatim => true, :plagiarism_begins_at => start, :plagiarism_ends_at => finish
      end
    end
  end
end