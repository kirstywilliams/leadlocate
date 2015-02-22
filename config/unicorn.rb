require 'sidekiq'
worker_processes 3
timeout 15
preload_app true

before_fork do |server, worker|

  Signal.trap 'TERM' do
    Rails.logger.info 'Unicorn intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', process.pid
  end
  #@sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection_pool.disconnect!

end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    Rails.logger.info 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end
  
  if defined?(ActiveRecord::Base)
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_POOL_FREQ'] || 10 #seconds
    config['pool'] = ENV['DB_POOL'] || 5
    ActiveRecord::Base.establish_connection(config)
  end
  
  ENV['REDISTOGO_URL'] ||= "redis://127.0.0.1:6379/"
  uri = URI.parse(ENV['REDISTOGO_URL'])
  $redis ||= Redis.new(host: uri.host, port: uri.port, password: uri.password, thread_safe: true)
  
  Sidekiq.configure_client do |config|
    config.redis = {
      size: 1
    }
  end
  
end