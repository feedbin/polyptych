web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: DB_POOL=10 bundle exec sidekiq -c 10