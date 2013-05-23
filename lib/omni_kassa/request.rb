module OmniKassa
  class Request
    # OmniKassa requirement, doesn't do anything
    KEY_VERSION = 1

    # OmniKassa requirement, doesn't do anything
    INTERFACE_VERSION = 'HP_1.0'

    REQUIRED = :merchant_id, :currency_code, :transaction_reference,
      :order_id, :amount, :normal_return_url, :key_version,
      :automatic_response_url, :customer_language

    OPTIONAL = :payment_mean_brand_list, :customer_language, :expiration_date

    attr_accessor *REQUIRED, *OPTIONAL

    def initialize
      self.key_version = KEY_VERSION

      # Load default settings into the request
      OmniKassa.request_settings.each do |key, value|
        send key.to_s + '=', value
      end
    end

    def valid?
      REQUIRED.map do |attr|
        value = send attr
        return false if value.nil?
      end
    end

    def perform
      # SSLv3 is a TravisCI requirement; won't run otherwise
      HTTParty.post(OmniKassa.url, query: query, ssl_version: :SSLv3).body
    end

    def transaction_reference
      @transaction_reference.call(order_id)
    end

    def query
      {
        InterfaceVersion: INTERFACE_VERSION,
        Data: data,
        Seal: seal
      }
    end

    protected

    def data
      data_hash.to_a.map {|a| a.join('=') }.join('|')
    end

    def data_hash
      REQUIRED.each do |param|
        value = send param
        raise RequestError, "attribute '#{param}' missing" if value.nil?
      end
      [OPTIONAL, REQUIRED].flatten.map do |param|
        value = send param
        [param.to_s.camelcase(:lower), value]
      end
    end

    def seal
      Digest::SHA2.new.update data + OmniKassa.secret_key
    end

    class RequestError < OmniKassaError; end
  end
end

