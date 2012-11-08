require 'resque/server'
Resque::Server.class_eval do
  use Rack::Auth::Basic do |user, password|
    password == "secret"
  end
end
