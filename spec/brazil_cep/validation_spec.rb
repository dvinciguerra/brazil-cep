# frozen_string_literal: true

require "spec_helper"

RSpec.describe Brazil::Cep do
  describe "#valid?" do
    subject(:validation) { Brazil::Cep.valid?(cep) }

    context "when the CEP is valid" do
      let(:cep) { "88220-000" }

      it { expect(validation).to be_truthy }
    end

    context "when the CEP is invalid" do
      let(:cep) { "00000000" }

      it { expect(validation).to be_falsey }
    end
  end
end
