if Rails.env.production?
  Resque.redis = 'food-tracker-001.mg1fnh.0001.usw2.cache.amazonaws.com:6379'
else
  Resque.redis = 'localhost:6379'
end

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  password == "katie"
end
