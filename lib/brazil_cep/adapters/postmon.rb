# frozen_string_literal: true

module Brazil
  module Cep
    module Adapters
      # Postmon provider adapter class
      # This class is responsible for fetching the address information from the Postmon provider
      class Postmon < Base
        provider base_url: "https://api.postmon.com.br/v1/cep/{{cep}}"

        private

        def transformation!
          address_params = {
            zipcode: @payload[:cep],
            state: @payload[:estado],
            city: @payload[:cidade],
            neighborhood: @payload[:bairro],
            street: @payload[:logradouro],
            complement: @payload[:complemento],
            meta: @payload.update(provider: :postmon)
          }

          Brazil::Cep::Address.new(**address_params)
        end
      end
    end
  end
end
