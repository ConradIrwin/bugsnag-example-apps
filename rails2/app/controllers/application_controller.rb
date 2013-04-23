# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_bugsnag_notify :awesome

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected
  def awesome(notification)
    puts "\n\n\n\nJAMES AWESOME\n\n\n\n"
  end
end
