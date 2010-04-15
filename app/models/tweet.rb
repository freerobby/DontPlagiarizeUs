class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :detection
end