

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'],
  {
    access_type: 'offline',
    # scope: 'user email'        #'https://www.googleapis.com/auth/userinfo.email',
    # provider_ignores_state: true,
    # redirect_uri: 'https://accounts.google.com/o/oauth2/auth'
  }

end
