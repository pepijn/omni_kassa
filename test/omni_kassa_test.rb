require 'omni_kassa/test_helper'

class HelloWorldTest < MiniTest::Unit::TestCase
  include Capybara::DSL

  Capybara.default_driver = :selenium

  def setup
    Capybara.app = Sinatra::Application.new
  end

  def test_amount_1337
    visit '/1337'
    assert page.has_content? "13,37"
    find(:xpath, '//div[@class="availablePaymentMeans"]/div[2]/a').click
    select 'Issuer Simulation 0 : Short', from: 'issuerComponent'
    click_on 'Akkoord'
    click_on 'Confirm Transaction'
    click_on 'Verder'
    click_on 'Continue'

    # FIXME: Annoying Firefox security warning
    assert page.has_content? 'success'
  end
end

