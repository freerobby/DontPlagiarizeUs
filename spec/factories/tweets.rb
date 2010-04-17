Factory.define :tweet do |f|
  f.text "Some tweet text"
  f.sequence(:twitter_id) {|s| s}
  f.tweeted_at Time.now
  f.detection {|d| d.association(:detection)}
end