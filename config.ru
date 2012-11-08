# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Polyptych::Application

app = Rack::Builder.new {

  map "/resque" do
    run Resque::Server
  end

  map "/" do
    run Polyptych::Application
  end
}.to_app

run app