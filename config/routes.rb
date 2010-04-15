ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'high_voltage/pages', :action => :show, :id => :home
  
  map.resources :detections, :only => [:new, :create, :show, :update]
end
