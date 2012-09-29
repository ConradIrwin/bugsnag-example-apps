require "rubygems"
require "bundler"
require "logger"
Bundler.require


class BugsnagFatalException < RuntimeError; end


# Configure Bugsnag
Bugsnag.configure do |config|
  config.api_key = "c9d60ae4c7e70c4b6c4ebd3e8056d2b8"
  config.endpoint = "localhost:8000"
  config.notify_release_stages = ["development", "production"]
end


# Hook into the top level error_handler
EventMachine.error_handler do |e|
  puts "FOUND AN ERROR"
  Bugsnag.notify(e)
  raise e
end

# Make a long running job using EventMachine::Deferrable
class SomeLongRunningJob
  include EventMachine::Deferrable
  
  def initialize(crash=false)
    puts "Started long running job"

    # Simulate a shit ton of work
    timer = EventMachine::Timer.new(5) do
      raise BugsnagFatalException.new("Crashed in SomeLongRunningJob") if crash

      puts "Finished long running job"
      self.succeed
    end
  end
end


# Define our rack app
class App < Sinatra::Base
  get "/" do
    "Hello from Sinatra EventMachine app! GET /job to run a long running job, /crash to make me crash."
  end

  get "/job" do 
    puts "Started request"

    EventMachine.next_tick do
      puts "IN HERE"
      job = SomeLongRunningJob.new
      job.callback { puts "Callback knows the job finished" }
      job.errback { puts "Callback knows the job failed" }
    end

    puts "Finished request"
    "Done"
  end
  
  get "/crash" do
    puts "Started request"
  
    EventMachine.next_tick do
      job = SomeLongRunningJob.new(true)
      job.callback { puts "Callback knows the job finished" }
      job.errback { puts "Callback knows the job failed" }
    end
  
    puts "Finished request"
    "Done"
  end
end