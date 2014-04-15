require 'bundler/setup'
require 'rake'
require 'rake/testtask'
require 'bundler'

task default: :test

Rake::TestTask.new do |t|
  t.libs << 'test/lib'
  t.pattern = 'test/*_test.rb'
end

Bundler::GemHelper.install_tasks

