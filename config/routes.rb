ActionController::Routing::Routes.draw do |map|
  map.root :controller => :detections, :action => :index
  
  # map.resources :detections, :only => [:index, :new, :create, :show, :update]
  
  # Map rest of namespace to profiles so "/graysky" works
  # Trick rails into using singular for profile actions (i.e. follow_user_profile instead of follow_user_profiles)
  map.resources :detections, :controller => :detections, :as => "i", :requirements => {:id => /\w+/}
  map.profile ':id', :controller => :detections, :action => :show
end
