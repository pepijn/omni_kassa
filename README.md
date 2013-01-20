# OmniKassa 
[![Gem Version](https://badge.fury.io/rb/omni_kassa.png)][gem]
[![Build Status](https://secure.travis-ci.org/pepijn/omni_kassa.png?branch=master)](https://travis-ci.org/pepijn/omni_kassa) 
[![Dependency Status](https://gemnasium.com/pepijn/omni_kassa.png)](https://gemnasium.com/pepijn/omni_kassa) 
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/pepijn/omni_kassa)

Easier Rabobank OmniKassa payments. Extracted from www.studysquare.nl. [RDocs](http://rdoc.info/projects/pepijn/omni_kassa).

[gem]: https://rubygems.org/gems/omni_kassa

Installation
------------

Supports Ruby 1.9.2, 1.9.3 and 2.0.0. Add to your Gemfile:

```ruby
gem 'omni_kassa'
```

Run `bundle` and add your personal configuration. The example below is the official test configuration.

```ruby
OmniKassa.config(
  secret_key:   '002020000000001_KEY1',
  merchant_id:  '002020000000001',
  currency_code: 978, # Euro
  url: 'https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet',
  transaction_reference: lambda { |order_id| "omnikassatest#{Time.now.to_i}" },
  customer_language: :nl
)
```

Using Rails? Use different OmniKassa configurations by adding them in their respective `config/environments/{development,test,production}.rb` environment configuration files.

Usage
-----

### Request

The example below uses an `OrdersController#create` action to create an order from `params[:order]` and sets up the OmniKassa request.

```ruby
class OrdersController
  def create
    # Save order in database
    @order = Order.create(params[:order])

    # OmniKassa preparation
    omnikassa                   = OmniKassa::Request.new
    omnikassa.order_id          = @order.id
    omnikassa.amount            = @order.amount
    omnikassa.normal_return_url = payments_url

    # Redirects user to OmniKassa
    render text: omnikassa.perform
  end
end
```

### Response

```ruby
class PaymentsController
  def create
    response = OmniKassa::Response.new(params)

    @order = Order.find(response.order_id)

    if response.successful?
      @order.payed = true
      @order.save

      redirect_to root_url, success: "Payment succeeded"
    else
      redirect_to root_url, alert: "Payment failed"
    end
  end
end
```
