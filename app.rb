require 'omni_kassa'
require './test_settings'

get '/' do
  redirect '1337'
end

get '/:amount' do
  omnikassa = OmniKassa::Request.new
  omnikassa.order_id = rand(1337)
  omnikassa.amount = params[:amount]
  omnikassa.normal_return_url = request.url
  omnikassa.perform
end

post '/:amount' do
  omnikassa = OmniKassa::Response.new(params)

  data = {
    raw: omnikassa,
    response_code: omnikassa.response_code,
    response: omnikassa.response,
    succesful: omnikassa.successful?
  }
  puts data.to_yaml
  render omnikassa.response
end

