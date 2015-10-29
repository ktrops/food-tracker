require 'resque/tasks'
require 'resque/scheduler/tasks'



namespace :resque do
  task :setup  => :environment do
    require 'resque'

    Resque.redis = 'localhost:6379'
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    Resque.schedule = YAML.load_file('config/expiration_date_schedule.yml')

   # require 'app/workers/check_expiration_date'
  end

  task :scheduler => :setup_schedule
end
