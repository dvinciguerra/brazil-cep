# frozen_string_literal: true

module Brazil
  module Cep
    # Adapters class namespace
    module Adapters
      # autoload default adapters
      autoload :Base, "brazil_cep/adapters/base"
      autoload :Viacep, "brazil_cep/adapters/viacep"
      autoload :Postmon, "brazil_cep/adapters/postmon"
      autoload :RepublicaVirtual, "brazil_cep/adapters/republica_virtual"
      autoload :CorreiosWeb, "brazil_cep/adapters/correios_web"

      # list of provider keys and classes
      PROVIDERS = {
        viacep: Viacep,
        postmon: Postmon,
        republica_virtual: RepublicaVirtual,
        correios_web: CorreiosWeb
      }

      private_constant :PROVIDERS

      # get providers
      # @return [Hash] providers
      def self.providers
        PROVIDERS
      end

      # register a provider
      #
      # @example
      #   Brazil::Cep::Adapters.register(:custom_provider, Brazil::Cep::Adapters::CustomProvider)
      #
      # @param provider_key [Symbol] provider key
      # @param provider_class [Class] provider class
      def self.register(provider_key, provider_class)
        PROVIDERS[provider_key] = provider_class
      end

      # get provider instance
      # @param provider [Symbol] provider key
      # @return [Base] provider instance
      def self.get(provider = :viacep)
        PROVIDERS[provider].new
      end
    end
  end
end
