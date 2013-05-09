Gem::Specification.new do |s|
  s.name    = 'omni_kassa'
  s.version = '1.2.1'
  s.author  = 'Pepijn Looije'
  s.email   = 'pepijn@plict.nl'
  s.description = s.summary = 'Easier Rabobank OmniKassa payments'
  s.homepage = 'https://github.com/pepijn/omni_kassa'

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'httparty'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sinatra'
  #s.add_development_dependency 'capybara'

  s.files = Dir["#{File.dirname(__FILE__)}/**/*"]
end

