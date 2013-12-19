require 'httparty'
require 'active_support/core_ext/string'

module OmniKassa
  REQUEST_SETTINGS = :merchant_id, :currency_code, :transaction_reference,
    :customer_language, :key_version
  SETTINGS = REQUEST_SETTINGS + [:secret_key, :url]

  def self.config(settings)
    for setting in SETTINGS
      value = settings[setting.to_sym]
      raise ConfigError, "config setting '#{setting}' missing" if value.nil?

      class_variable_set '@@' + setting.to_s, value
    end
  end

  def self.request_settings
    Hash[REQUEST_SETTINGS.map do |setting|
      [setting.to_s, class_variable_get('@@' + setting.to_s)]
    end]
  end

  def self.secret_key
    @@secret_key
  end

  def self.url
    @@url
  end

  # The common base class for all exceptions raised by OmniKassa
  class OmniKassaError < StandardError
  end

  # Raised if something is wrong with the configuration parameters
  class ConfigError < OmniKassaError
  end
end

require 'omni_kassa/request'
require 'omni_kassa/response'

