
require 'resque'
require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'resque/scheduler'



namespace :resque do
  puts "Loading Rails environment for Resque"
  task :setup  => :environment do


    if Rails.env.production?
      Resque.redis = 'food-tracker-001.mg1fnh.0001.usw2.cache.amazonaws.com:6379'
    else
      Resque.redis = 'localhost:6379'
    end

  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    Resque.schedule = YAML.load_file('config/expiration_date_schedule.yml')

   # require 'app/workers/check_expiration_date'
  end

  task :scheduler => :setup_schedule
end
