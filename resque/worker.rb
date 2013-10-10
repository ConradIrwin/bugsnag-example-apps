require "resque"
require "bugsnag"

Bugsnag.configure do |config|
  config.api_key = "066f5ad3590596f9aa8d601ea89af845"
  config.release_stage = "production"
end

class Worker
  @queue = :james

  def self.perform
    puts "doing something"
    raise "crash!"
    puts "finished doing something"
  end
end