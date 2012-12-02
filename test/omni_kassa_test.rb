require 'omni_kassa/test_helper'

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    Sinatra::Application.new
  end

  def test_it_works
    visit "/"
    follow_redirect!
    click_button
    assert_contain 'hoi'

  end
end

