require 'rubygems'
require 'bundler/setup'
require 'omni_kassa'

require 'minitest/unit'
require 'webrat'
require 'rack/test'
require 'sinatra'

require './app'

Webrat.configure do |config|
  config.mode = :selenium
end

MiniTest::Unit.autorun

