task :cron => :environment do
  Rake::Task["detections:update_later"].invoke
end