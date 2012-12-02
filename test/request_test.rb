require 'omni_kassa/test_helper'

ORDER_ID = rand(10000)
AMOUNT   = rand(10000)

class RequestTest < MiniTest::Unit::TestCase
  def setup
    @request = OmniKassa::Request.new
    @request.order_id          = ORDER_ID
    @request.amount            = AMOUNT
    @request.normal_return_url = 'https://google.com'
  end

  def test_attributes
    assert_equal 1, @request.key_version
    assert_equal "002020000000001", @request.merchant_id
    assert_equal 978, @request.currency_code
    assert_equal "omnikassatest#{Time.now.to_i}",
      @request.transaction_reference

    assert_equal ORDER_ID, @request.order_id
    assert_equal AMOUNT, @request.amount
    assert_equal 'https://google.com',
      @request.normal_return_url
  end

  def test_invalid_without_order_id
    @request.order_id = nil
    refute @request.valid?
  end

  def test_invalid_without_amount
    @request.amount = nil
    refute @request.valid?
  end

  def test_invalid_without_normal_return_url
    @request.normal_return_url = nil
    refute @request.valid?
  end

  def test_perform_invalid
    @request.amount = 0
    assert_match /ERROR/, @request.perform
  end

  def test_perform_valid
    refute_match /ERROR/, @request.perform
  end
end
