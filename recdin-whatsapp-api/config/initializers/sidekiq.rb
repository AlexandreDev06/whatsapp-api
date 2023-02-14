# Be sure to restart your server when you modify this file.

# It is important to note that to configure the location of Redis, you must
# define both the Sidekiq.configure_server and Sidekiq.configure_client blocks.
Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', nil) }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', nil) }
end
