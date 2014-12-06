# Run via rack server
require 'bundler/setup'
require 'volt/server'
run Volt::Server.new.app

# Heroku New Relic Addon
require 'newrelic_rpm' if ENV['RACK_ENV'] == 'production'
