# frozen_string_literal: true

require "spec_helper"

RSpec.describe Brazil::Cep::Adapters do
  describe ".providers" do
    it "returns a list of providers" do
      expect(described_class.providers).to include(
        viacep: described_class::Viacep,
        postmon: described_class::Postmon,
        republica_virtual: described_class::RepublicaVirtual
      )
    end
  end

  describe ".register" do
    it "registers a provider" do
      Brazil::Cep::Adapters::CustomProvider = Class.new(Brazil::Cep::Adapters::Base) do
      end

      described_class.register(:custom_provider, described_class::CustomProvider)

      expect(described_class.providers).to include(custom_provider: described_class::CustomProvider)
    end
  end

  describe ".get" do
    it "returns a default (viacep) provider instance" do
      expect(described_class.get).to be_a(described_class::Viacep)
    end

    it { expect(described_class.get(:postmon)).to be_a(described_class::Postmon) }

    it { expect(described_class.get(:republica_virtual)).to be_a(described_class::RepublicaVirtual) }
  end
end
