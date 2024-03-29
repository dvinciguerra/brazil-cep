# frozen_string_literal: true

module Brazil
  module Cep
    module Adapters
      # Cep Aberto provider adapter class
      # This class is responsible for fetching the address information from the Cep Aberto provider
      class CepAberto < Base
        provider base_url: "https://www.cepaberto.com/ceps/{{cep}}.json"

        private

        def transformation!
          raise Brazil::Cep::ZipcodeNotFound, @response if @payload[:erro] == true

          address_params = {
            zipcode: @payload[:cep],
            state: @payload[:estado][:sigla],
            city: @payload[:cidade][:nome],
            neighborhood: @payload[:bairro],
            street: @payload[:logradouro],
            complement: @payload[:complemento],
            meta: @payload.update(provider: :cep_aberto)
          }

          Brazil::Cep::Address.new(**address_params)
        end
      end
    end
  end
end
