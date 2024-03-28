# frozen_string_literal: true

module Brazil
  module Cep
    module Adapters
      # Viacep provider adapter class
      # This class is responsible for fetching the address information from the Viacep provider
      class Viacep < Base
        provider base_url: "https://viacep.com.br/ws/{{cep}}/json/"

        private

        def transformation!
          raise Brazil::Cep::ZipcodeNotFound, @response if @payload[:erro] == true

          address_params = {
            zipcode: @payload[:cep],
            state: @payload[:uf],
            city: @payload[:localidade],
            neighborhood: @payload[:bairro],
            street: @payload[:logradouro],
            complement: @payload[:complemento],
            meta: @payload.update(provider: :viacep)
          }

          Brazil::Cep::Address.new(**address_params)
        end
      end
    end
  end
end
