# frozen_string_literal: true

require_relative "brazil_cep/version"
require_relative "brazil_cep/address"
require_relative "brazil_cep/adapters"

module Brazil
  # Brazil::Cep providers a simple way to fetch address information from a Brazilian CEP
  # @public
  module Cep
    class Error < StandardError; end
    class RequestError < Error; end

    # fetch address information from a Brazilian CEP
    # @param [String] cep the CEP to fetch
    # @return [Hash] the address information
    def self.fetch(cep, provider: :viacep)
      provider = Adapters.get(provider)
      provider.get(cep)
    end
  end
end
