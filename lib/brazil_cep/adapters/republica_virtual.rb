# frozen_string_literal: true

module Brazil
  module Cep
    module Adapters
      # Republica Virtual provider adapter class
      # This class is responsible for fetching the address information from the Republica Virtual provider
      class RepublicaVirtual < Base
        provider base_url: "http://cep.republicavirtual.com.br/web_cep.php?cep={{cep}}&formato=json"

        private

        def transformation!
          address_params = {
            zipcode: @cep,
            state: @payload[:uf],
            city: @payload[:cidade],
            neighborhood: @payload[:bairro],
            street: "#{@payload[:tipo_logradouro]} #{@payload[:logradouro]}",
            complement: @payload[:complemento],
            meta: @payload.update(provider: :republica_virtual)
          }

          Brazil::Cep::Address.new(**address_params)
        end
      end
    end
  end
end
