lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'omni_kassa/version'

Gem::Specification.new do |s|
  s.name    = 'omni_kassa'
  s.version = OmniKassa::VERSION::STRING
  s.author  = 'Pepijn Looije'
  s.email   = 'pepijn@plict.nl'
  s.description = s.summary = 'Easier Rabobank OmniKassa payments'
  s.homepage = 'https://github.com/pepijn/omni_kassa'
  s.licenses = 'MIT'

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'httparty', '>= 0.9.0'
  s.add_dependency 'activesupport', '>= 3.2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sinatra'
  #s.add_development_dependency 'capybara'

  s.files = Dir.glob("{lib,test}/**/*") + %w(README.md LICENSE)
end

