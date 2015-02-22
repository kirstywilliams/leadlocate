ENV['REDISTOGO_URL'] ||= 'redis://localhost:6379'
uri = URI.parse(ENV['REDISTOGO_URL'])
$redis = REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)