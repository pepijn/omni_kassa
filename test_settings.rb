OmniKassa.config(
  secret_key: '002020000000001_KEY1',
  merchant_id: '002020000000001',
  key_version: 1,
  currency_code: 978,
  transaction_reference: lambda {|order_id| "omnikassatest#{Time.now.to_i}" },
  url: 'https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet',
  customer_language: :nl
)

