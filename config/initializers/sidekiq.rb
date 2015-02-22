require 'sidekiq'

ENV["REDISTOGO_URL"] ||= "redis://127.0.0.1:6379/"
uri = URI.parse(ENV["REDISTOGO_URL"])
$redis ||= Redis.new(host: uri.host, port: uri.port, password: uri.password, thread_safe: true)


if Rails.env == "development"

  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end

end

Sidekiq.configure_server do |config|

  config.redis = { :size => 5 }
  
end