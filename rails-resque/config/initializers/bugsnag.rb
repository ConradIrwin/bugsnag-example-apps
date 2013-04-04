require 'resque/failure/multiple'
require 'resque/failure/redis'
require 'resque/failure/bugsnag'

Bugsnag.configure do |config|
  config.api_key = "908e5bd2815f286677e0d9bc92f6e1e1"
  config.use_ssl = true
end

Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis, Resque::Failure::Bugsnag]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression