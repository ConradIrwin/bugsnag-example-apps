require 'sidekiq'
require 'bugsnag'

Bugsnag.configure do |config|
  config.api_key = '066f5ad3590596f9aa8d601ea89af845'
end

class Wokker
  include Sidekiq::Worker

  def perform()
    throw "hoops"
  end
end

Wokker.delay.perform
