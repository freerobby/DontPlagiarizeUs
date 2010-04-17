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
  end
end
