# frozen_string_literal: true

module Brazil
  module Cep
    # Adapters class namespace
    module Adapters
      autoload :Base, "brazil_cep/adapters/base"
      autoload :Viacep, "brazil_cep/adapters/viacep"
      autoload :Postmon, "brazil_cep/adapters/postmon"
      autoload :RepublicaVirtual, "brazil_cep/adapters/republica_virtual"

      # list of provider keys and classes
      PROVIDERS = {
        viacep: Viacep,
        postmon: Postmon,
        republica_virtual: RepublicaVirtual
      }.freeze

      def self.get(provider = :viacep)
        PROVIDERS[provider].new
      end
    end
  end
end
