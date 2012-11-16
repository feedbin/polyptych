require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'user' && password == 'secret'
end 
