# frozen_string_literal: true

module Brazil
  module Cep
    module Adapters
      # Correios Web provider adapter class
      # This class is responsible for fetching the address information from the Correios Web provider
      class CorreiosWeb < Base
        provider base_url: "https://buscacepinter.correios.com.br/app/endereco/carrega-cep-endereco.php"

        private

        def http_request(uri, **options, &block)
          http_options =
            { open_timeout: open_timeout, read_timeout: read_timeout, write_timeout: write_timeout }
            .update(**options)

          http_options[:use_ssl] = uri.scheme == "https"

          Net::HTTP.start(uri.host, uri.port, **http_options) do |http|
            request = Net::HTTP::Post.new(uri)
            request.set_form_data(params)
            headers.each { |key, value| request[key] = value }

            @response = http.request(request)

            block.call(@response)
          end
        end

        def headers
          { "Referer" => "https://buscacepinter.correios.com.br/app/endereco/index.php" }
        end

        def params
          { pagina: "/app/endereco/index.php", cepaux: nil, endereco: @cep, tipoCEP: "ALL" }
        end

        def transformation!
          data = Array(@payload[:dados]).first
          raise Brazil::Cep::ZipcodeNotFound, @response if data.nil?

          street, *complement = data[:logradouroDNEC].split(" - ")

          raise Brazil::Cep::ZipcodeNotFound, @response if data[:cep] != @cep.sub("-", "")

          address_params = {
            zipcode: data[:cep],
            state: data[:uf],
            city: data[:localidade],
            neighborhood: data[:bairro],
            street: street,
            complement: complement.join(" - "),
            meta: @payload.update(provider: :correios_web)
          }

          Brazil::Cep::Address.new(**address_params)
        end
      end
    end
  end
end
