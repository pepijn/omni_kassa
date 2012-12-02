require 'rubygems'
require 'bundler/setup'
require 'omni_kassa'

require 'minitest/unit'
require 'capybara'
require 'capybara/dsl'
require 'rack/test'
require 'sinatra'

require './app'

MiniTest::Unit.autorun

