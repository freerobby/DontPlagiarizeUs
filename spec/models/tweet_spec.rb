require 'spec_helper'
describe Tweet do
  describe "factory" do
    it "works" do
      lambda {
        Factory.create :tweet
      }.should_not raise_error
    end
  end
  describe "validations" do
    it "requires twitter_id" do
      lambda {
        Factory.create :tweet, :twitter_id => nil
      }.should raise_error ActiveRecord::RecordInvalid
    end
    it "requires text" do
      lambda {
        Factory.create :tweet, :text => ""
      }.should raise_error ActiveRecord::RecordInvalid
    end
    it "requires tweeted_at" do
      lambda {
        Factory.create :tweet, :tweeted_at => nil
      }.should raise_error ActiveRecord::RecordInvalid
    end
    it "belongs to a detection" do
      lambda {
        Factory.create :tweet, :detection_id => nil
      }.should raise_error ActiveRecord::RecordInvalid
    end
    it "exists only once for a given detection" do
      first = Factory.create :tweet, :twitter_id => 25
      lambda {
        Factory.create :tweet, :twitter_id => 25, :detection => first.detection
      }.should raise_error ActiveRecord::RecordInvalid
    end
  end
  
  describe "#is_original?" do
    it "true if not plagiarism" do
      (Factory.create :tweet, :plagiarism_of => nil).is_original?.should == true
    end
    it "false if plagiarism" do
      (Factory.create :tweet, :plagiarism_of => 25).is_original?.should == false
    end
  end
  describe "#is_fraud?" do
    it "true if plagiarism" do
      (Factory.create :tweet, :plagiarism_of => 25).is_fraud?.should == true
    end
    it "false if not plagiarism" do
      (Factory.create :tweet, :plagiarism_of => nil).is_fraud?.should == false
    end
  end
end
