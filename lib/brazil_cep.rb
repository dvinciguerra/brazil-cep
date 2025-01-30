# frozen_string_literal: true

require_relative "brazil_cep/version"
require_relative "brazil_cep/address"
require_relative "brazil_cep/adapters"
require_relative "brazil_cep/validation"

module Brazil
  # Brazil::Cep providers a simple way to fetch address information from a Brazilian CEP
  # @public
  module Cep
    # generic error class
    class Error < StandardError; end

    # request error class
    class RequestError < Error
      attr_reader :status, :code, :response

      def initialize(response)
        @response = response
        @status = response.message || "Undefined"
        @code = response.code.to_i

        super("Request Error: #{code} #{status} - #{response.body[0..1000].inspect}")
      end
    end

    # zipcode not found error class
    class ZipcodeNotFound < RequestError; end

    include Validation

    # fetch address information from a Brazilian CEP
    # @param [String] cep the CEP to fetch
    # @return [Hash] the address information
    def self.fetch(cep, provider: :viacep)
      provider = Adapters.get(provider)
      provider.get(cep)
    end
  end
end
