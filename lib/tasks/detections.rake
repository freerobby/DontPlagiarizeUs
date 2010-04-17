namespace :detections do
  desc "Look for past tweets on all detections or for a given screen name"
  task :update_earlier => :environment do
    if ENV['SCREEN_NAME'].nil?
      Detection.all.each do |d|
        d.update_earlier!
      end
    else
      Detection.find_by_screen_name(ENV['SCREEN_NAME']).update_earlier!
    end
  end
  
  desc "Look for new tweets on all detections or for a given screen name"
  task :update_later => :environment do
    if ENV['SCREEN_NAME'].nil?
      Detection.all.each do |d|
        d.update_later!
      end
    else
      Detection.find_by_screen_name(ENV['SCREEN_NAME']).update_later!
    end
  end
  
  desc "Remove plagiarisms of tweets that don't exist"
  task :remove_nonexistent_plagiarisms => :environment do
    puts "Scanning #{Tweet.count} tweets for plagiarisms of missing tweets."
    Tweet.find_each do |t|
      puts "At tweet: #{t.id}" if t.id % 1000 == 0
      if (t.plagiarism_of != nil) && (Tweet.id_eq(t.plagiarism_of).size == 0)
        puts "Removing tweet: #{t.id}"
        t.destroy
      end
    end
  end
  
  # takes optional SCREEN_NAME= variable
  desc "Remove duplicate original tweets from each user"
  task :remove_duplicate_original_tweets => :environment do
    def process_detection(detection_id)
      detection = Detection.find(detection_id)
      puts "Detecting for #{detection.screen_name}"
      counter = 0
      detection.tweets.each do |tweet|
        counter += 1
        puts "At tweet #{counter} of #{detection.tweets.count}" if counter % 100 == 0
        all_tweets = Tweet.detection_id_eq(detection.id).author_null.text_eq(tweet.text).ascend_by_created_at
        if all_tweets.size > 1
          puts "Found tweet #{all_tweets.first.twitter_id} with #{all_tweets.size} copies"
          tweet_id = all_tweets.first.id
          all_tweets.id_does_not_equal(tweet_id).destroy_all
        end
      end
    end
    if ENV['SCREEN_NAME'].nil?
      puts "Removing duplicate tweets for #{Detection.count} users."
      Detection.find_each {|detection| process_detection(detection.id)}
    else
      process_detection(Detection.find_by_screen_name(ENV['SCREEN_NAME']))
    end
  end
end