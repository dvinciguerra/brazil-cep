# frozen_string_literal: true

require "json"
require "net/http"

module Brazil
  module Cep
    module Adapters
      # Base adapter class
      # @abstract
      class Base
        def self.provider(**params)
          @__provider = params
        end

        # class constructor method
        # @param [String] cep the CEP to fetch (optional)
        def initialize(cep = nil)
          @cep = cep
          @__provider = self.class.instance_variable_get(:@__provider) || {}

          @open_timeout = ENV.fetch("BRAZIL_CEP_OPEN_TIMEOUT", 3).to_i
          @read_timeout = ENV.fetch("BRAZIL_CEP_READ_TIMEOUT", 3).to_i
          @write_timeout = ENV.fetch("BRAZIL_CEP_WRITE_TIMEOUT", 3).to_i
        end

        # fetch address information from a Brazilian CEP
        # @param [String] value the CEP to fetch
        # @return [Hash] the address information
        def fetch(value = nil)
          @cep = value unless value.nil?

          http_request(provider_url) do |http_response|
            raise Brazil::Cep::RequestError, http_response unless http_response.is_a?(Net::HTTPSuccess)
          end

          deserialization!
          transformation!
        end

        alias get fetch

        private

        attr_reader :cep, :response, :payload, :open_timeout, :read_timeout, :write_timeout

        def http_request(uri, **options, &block)
          http_options =
            { open_timeout: open_timeout, read_timeout: read_timeout, write_timeout: write_timeout }
            .update(**options)

          http_options[:use_ssl] = uri.scheme == "https"

          Net::HTTP.start(uri.host, uri.port, **http_options) do |http|
            request = Net::HTTP::Get.new(uri)
            @response = http.request(request)

            block.call(@response)
          end
        end

        # returns the provider URL from provider base_url attribute
        # @return [URI] the provider URL
        def provider_url
          raise ArgumentError unless @__provider.key?(:base_url)

          URI.parse(@__provider[:base_url].gsub("{{cep}}", cep))
        end

        # deserialization method
        # @return [Hash] the deserialized payload
        def deserialization!
          @payload = JSON.parse(response.body, symbolize_names: true)
        end

        # transformation method
        # @return [Hash] the transformed payload
        def transformation!
          @payload
        end
      end
    end
  end
end
