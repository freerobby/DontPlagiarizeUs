# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100417164701) do

  create_table "detections", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screen_name", :null => false
  end

  create_table "tweets", :force => true do |t|
    t.integer  "detection_id"
    t.string   "text"
    t.string   "author"
    t.datetime "tweeted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plagiarism_of"
    t.datetime "last_checked_if_plagiarized"
    t.boolean  "plagiarism_verbatim",         :default => false
    t.integer  "plagiarism_begins_at"
    t.integer  "plagiarism_ends_at"
    t.integer  "twitter_id",                  :default => 0
  end

end
