# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_twitter_handle(screen_name)
    link_to "@#{screen_name}", "http://twitter.com/#{screen_name}"
  end
end
