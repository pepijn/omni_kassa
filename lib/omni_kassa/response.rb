module OmniKassa
  class Response
    RESPONSE_CODES = {
      0  => :success,
      17 => :cancelled,
      60 => :pending,
      90 => :pending,
      97 => :expired
    }

    attr_accessor :data, :seal, :order_id, :response_code, :amount

    def initialize(params)
      self.data = params[:Data]
      self.seal = params[:Seal]

      verify_seal!
    end

    def pending?
      response == :pending
    end

    def successful?
      response == :success
    end

    def response
      RESPONSE_CODES[response_code] || :unknown_failure
    end

    def data=(data)
      @data = data
      parse_data_hash
    end

    def response_code=(response_code)
      raise ResponseCodeError if response_code.to_s.scan(/\D/).present?
      @response_code = response_code.to_i
    end

    protected

    def verify_seal!
      seal = Digest::SHA2.new.update(data + OmniKassa.secret_key)
      raise SealMismatchError if seal != self.seal
    end

    def parse_data_hash
      data_hash.each do |key, value|
        key = key.underscore + '='
        send key, value if respond_to? key
      end
    end

    def data_hash
      Hash[data.split('|').map { |a| a.split('=') }]
    end

    class SealMismatchError < OmniKassaError; end
    class ResponseCodeError < OmniKassaError; end
  end
end

