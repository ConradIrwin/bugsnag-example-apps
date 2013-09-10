require "rubygems"
require "bundler"

Bundler.require

# Configure Bugsnag
Bugsnag.configure do |config|
  config.api_key = "36e5bae7d42beabd10010cb5562a21a5"
  config.endpoint = "localhost:8000"
  config.notify_release_stages = ["development", "production"]
  config.logger.level = Logger::INFO
end

# Include the Bugsnag rack middleware
enable :sessions
use Bugsnag::Rack
#enable :raise_errors
#set :show_exceptions, false

# Set up urls to respond to
get "/" do
  "Hello from Sinatra! GET /crash to make me crash."
end

get "/crash" do
  raise "Crash me baby one more timedd"
end

not_found do
  'This is nowhere to be found.'
end

error do
  Bugsnag.notify env['sinatra.error']
  'Sorry there was a nasty error - ' + env['sinatra.error'].to_s
end