require 'spec_helper'
describe Detection do
  describe "factory" do
    it "works" do
      lambda {
        Factory.create :detection
      }.should_not raise_error
    end
  end
  describe "validations" do
    it "requires screen_name" do
      lambda {
        Factory.create :detection, :screen_name => ""
      }.should raise_error ActiveRecord::RecordInvalid
    end
    it "allows only one detection per screen name" do
      lambda {
        Factory.create :detection, :screen_name => "robby"
        Factory.create :detection, :screen_name => "robby"
      }.should raise_error ActiveRecord::RecordInvalid
    end
  end
end
