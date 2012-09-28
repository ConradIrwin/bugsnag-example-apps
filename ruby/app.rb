#!/usr/bin/env ruby

require "rubygems"
require "bundler"

Bundler.require

# Define some custom exception classes
class BugsnagFatalException < RuntimeError; end
class BugsnagNonFatalException < RuntimeError; end

# Configure Bugsnag
Bugsnag.configure do |config|
  config.api_key = "c9d60ae4c7e70c4b6c4ebd3e8056d2b8"
  config.endpoint = "localhost:8000"
  config.notify_release_stages = ["development", "production"]
end

def my_app
  puts "Running example ruby app, about to crash..."

  Bugsnag.notify(BugsnagNonFatalException.new("Non-fatal exception"), {
    :user => "james"
  })

  raise BugsnagFatalException.new("Crash-o-la")
end

begin
  my_app()
rescue Exception => e
  Bugsnag.notify(e)

  raise
end