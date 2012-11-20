require 'securerandom' # bug in Sidekiq as of 2.2.1
require 'sidekiq'
require 'sidekiq/web'
require 'autoscaler/sidekiq'
require 'autoscaler/heroku_scaler'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  web_password = ENV['SIDEKIQ_PASSWORD'] || 'secret'
  username == 'admin' && password == web_password
end 

heroku = nil
if ENV['HEROKU_APP']
  heroku = Autoscaler::HerokuScaler.new
end

Sidekiq.configure_client do |config|
  if heroku
    config.client_middleware do |chain|
      chain.add Autoscaler::Sidekiq::Client, 'default' => heroku
    end
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    if heroku
      p "Setting up auto-scaledown"
      chain.add(Autoscaler::Sidekiq::Server, heroku, 60)
    else
      p "Not scaleable"
    end
  end
end