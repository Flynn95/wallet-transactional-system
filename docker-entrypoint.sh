#!/bin/sh

bundle install
rake db:create
rake db:migrate
rails db:seed

rm -f tmp/pids/server.pid
bin/rails s -b 0.0.0.0
