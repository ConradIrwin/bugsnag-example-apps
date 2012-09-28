require "rubygems"
require "bundler"

class BugsnagFatalException < RuntimeError; end

Bundler.require

# Configure Bugsnag
Bugsnag.configure do |config|
  config.api_key = "c9d60ae4c7e70c4b6c4ebd3e8056d2b8"
  config.endpoint = "localhost:8000"
  config.notify_release_stages = ["development", "production"]
end


EventMachine.error_handler {}

puts "current handler" + EventMachine.error_handler.inspect

EventMachine.error_handler do |e|
  puts "FOUND AN ERROR"
  Bugsnag.notify(e)
  raise e
end

class SomeLongRunningJob
  include EventMachine::Deferrable
  
  def initialize(crash=false)
    puts "Started long running job"
    
    # Simulate a shit ton of work
    timer = EventMachine::Timer.new(5) do
      raise BugsnagFatalException.new("Crash in long running job") if crash

      puts "Finished long running job"
      self.succeed
    end
  end
end

class App
  def call(env)
    request = Rack::Request.new(env)

    case request.path
    when "/"
      puts "Started request"

      EventMachine.next_tick do
        job = SomeLongRunningJob.new
        job.callback { puts "Callback knows the job finished" }
        job.errback { puts "Callback knows the job failed" }
      end

      puts "Finished request"
        
      Rack::Response.new("HI THERE")
    else
      Rack::Response.new("Not found", 404)
    end
  end
end

run App.new