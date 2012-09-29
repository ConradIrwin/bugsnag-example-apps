require "rubygems"
require "bundler"

Bundler.require

# Configure Bugsnag
Bugsnag.configure do |config|
  config.api_key = "c9d60ae4c7e70c4b6c4ebd3e8056d2b8"
  config.endpoint = "localhost:8000"
  config.notify_release_stages = ["development", "production"]
end

# Include the Bugsnag rack middleware
use Bugsnag::Rack

# Set up urls to respond to
get "/" do
  "Hello from Sinatra! GET /crash to make me crash."
end

get "/crash" do
  raise "Crash me baby one more time"
end