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
end