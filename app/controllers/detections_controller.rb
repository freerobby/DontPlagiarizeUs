class DetectionsController < ApplicationController
  def show
  end
  def new
  end
  def create
    if !current_user.detection.nil?
      flash[:error] = "You already have a detection. You may update it but not create a new one."
      redirect_to detection_path(current_user.detection)
    else
      detection = Detection.new(:user => current_user)
      if detection.save
        flash[:notice] = "Your detections are complete!"
        redirect_to detection_path(current_user.detection)
      else
        flash[:error] = "Sorry, we couldn't run plagiarism detection on your account."
        redirect_to new_detection_path
      end
    end
  end
  def update
    if current_user.detection.nil?
      flash[:error] = "You must create a detection before you can update it."
      redirect_to new_detection_path
    else
      if current_user.detection.update!
        flash[:notice] = "Detections successfully updated."
        redirect_to detection_path(current_user.detection)
      else
        flash[:error] = "An error occurred. We could not run plagiarism detection on your account."
        redirect_to detection_path(current_user.detection)
      end
    end
  end
end
