class DetectionsController < ApplicationController
  def index
    @detections = Detection.screen_name_not_blank
  end
  def show
    @detection = Detection.find_by_screen_name(params[:id])
    @detection = Detection.create(:screen_name => params[:id]) if @detection.nil?
    @detection.update_later! if @detection.tweets.size == 0
  end
  def new
    @detection = Detection.new
  end
  def create
    detection = Detection.find_by_screen_name(params[:detection][:screen_name])
    if !detection.nil?
      redirect_to detection_path(detection)
    else
    detection = Detection.new(params[:detection])
      if detection.save
        detection.update_later!
        flash[:notice] = "Your detections are complete!"
        redirect_to profile_path(detection)
      else
        flash[:error] = "Sorry, we couldn't run plagiarism detection on that account."
        redirect_to root_path
      end
    end
  end
  def update
    d = Detection.find_by_screen_name(params[:id])
    if d.update_attributes(params[:detection])
      if params[:direction].nil?
        flash[:error] = "You must specify whether you want to look at newer or older tweets."
        redirect_to profile_path(d)
      elsif params[:direction] == 'earlier'
        puts "Looking for earlier tweets"
        d.update_earlier!
      elsif params[:direction] == 'later'
        puts "Looking for more recent tweets"
        d.update_later!
      end
      flash[:notice] = "Tweet analysis complete!"
      redirect_to profile_path(d)
    else
      flash[:error] = "An error occurred. We could not run plagiarism detection on your account."
      redirect_to profile_path(d)
    end
  end
end
