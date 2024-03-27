# frozen_string_literal: true

RSpec.describe Brazil::Cep do
  context "when the CEP is valid" do
    subject(:address) { Brazil::Cep.fetch(cep) }

    let(:cep) { "01311-100" }

    it { expect(address).to be_a(Brazil::Cep::Address) }
  end
end
