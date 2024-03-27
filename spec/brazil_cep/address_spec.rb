# frozen_string_literal: true

require "spec_helper"

RSpec.describe Brazil::Cep::Address do
  subject(:address) { described_class.new(**address_params) }

  let(:address_params) do
    {
      zipcode: "01311-100",
      street: "Avenida Paulista",
      state: "SP",
      city: "São Paulo",
      neighborhood: "Bela Vista",
      complement: "Até 100 - lado par",
      meta: {
        cep: "01311-100",
        logradouro: "Avenida Paulista",
        complemento: "de 611 a 1045 - lado ímpar",
        bairro: "Bela Vista",
        localidade: "São Paulo",
        uf: "SP",
        ibge: "3550308",
        gia: "1004",
        ddd: "11",
        siafi: "7107",
        provider: :postmon
      }
    }
  end

  it { expect(address.zipcode).to eq("01311-100") }
  it { expect(address.street).to eq("Avenida Paulista") }
  it { expect(address.state).to eq("SP") }
  it { expect(address.city).to eq("São Paulo") }
  it { expect(address.neighborhood).to eq("Bela Vista") }
  it { expect(address.complement).to eq("Até 100 - lado par") }
  it { expect(address.provider).to eq(:postmon) }
end
