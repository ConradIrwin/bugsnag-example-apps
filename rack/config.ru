require "rubygems"
require "bundler"

Bundler.require

# Configure Bugsnag
Bugsnag.configure do |config|
  config.api_key = "c9d60ae4c7e70c4b6c4ebd3e8056d2b8"
  config.endpoint = "localhost:8000"
  config.notify_release_stages = ["development", "production"]
  config.project_root = "/Users/james/src/bugsnag/example-apps/rack"
end

# Include the Bugsnag rack middleware
use Bugsnag::Rack

# The rack app
app = Proc.new do |env|
  request = Rack::Request.new(env)
  
  case request.path
  when "/"
    Rack::Response.new("Hello from Rack! GET /crash to make me crash.")
  when "/crash"
    Bugsnag.before_notify_callbacks << lambda {|notif, ex| 
      notif.add_tab :something, {
        :useful => "data",
        :ip => request.ip
      }
    }

    raise "Crashtown USA"
  else
    Rack::Response.new("Not found", 404)
  end
end

run app