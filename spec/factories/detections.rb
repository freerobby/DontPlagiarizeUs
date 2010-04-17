Factory.define :detection do |f|
  f.sequence(:screen_name) {|s| "twitterhandle#{s}"}
end