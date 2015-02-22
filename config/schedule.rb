set :environment, 'development'

every 2.minutes do

  rake "scraping:leads", :environment => 'development', output: "log/cron.log"
  
end