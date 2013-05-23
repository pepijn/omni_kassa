require 'omni_kassa/test_helper'

RESPONSE_PARAMS =  {
  Data: "amount=1337|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=527|transactionDateTime=2012-12-02T21:41:01+01:00|transactionReference=omnikassatest1354480861|keyVersion=1|authorisationId=0020000006791167|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00",
  InterfaceVersion: "HP_1.0",
  Encode: '',
  Seal: '46204f0e97394293c9270b6313e78524027acba1f83d4ce9682848e1f5927ab3'
}

class ResponseTest < MiniTest::Unit::TestCase
  def setup
    @params = RESPONSE_PARAMS.clone
    @response = OmniKassa::Response.new(@params)
  end

  def test_attributes
    assert_equal "527", @response.order_id
    assert_equal "1337", @response.amount
  end

  def test_responses
    assert_equal :success, @response.response
    refute @response.pending?
    assert @response.successful?

    @response.response_code = 17
    assert_equal :cancelled, @response.response
    refute @response.pending?
    refute @response.successful?

    @response.response_code = 60
    assert_equal :pending, @response.response
    assert @response.pending?
    refute @response.successful?

    @response.response_code = 90
    assert_equal :pending, @response.response
    assert @response.pending?
    refute @response.successful?

    @response.response_code = 97
    assert_equal :expired, @response.response
    refute @response.pending?
    refute @response.successful?

    @response.response_code = 1 # not 0
    assert_equal :unknown_failure, @response.response
    refute @response.pending?
    refute @response.successful?
  end

  def test_invalid_seal
    @params[:Seal] = 'haxx0r'
    assert_raises OmniKassa::Response::SealMismatchError do
      OmniKassa::Response.new(@params)
    end
  end

  def test_invalid_response_code
    assert_raises OmniKassa::Response::ResponseCodeError do
      @response.response_code = '1337x'
    end
  end
end

