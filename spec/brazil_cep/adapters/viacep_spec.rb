# frozen_string_literal: true

require "spec_helper"

RSpec.describe Brazil::Cep::Adapters::Viacep do
  describe ".provider" do
    subject(:address) { described_class.new.fetch(zipcode) }

    let(:zipcode) { "01311-200" }

    it "returns a valid location based on zipcode" do
      expect(address.zipcode).to eq("01311-200")
    end

    context "when the zipcode is invalid" do
      let(:zipcode) { "99" }

      it "returns a request error" do
        expect { address.zipcode }.to raise_error(Brazil::Cep::RequestError)
      end
    end

    context "when the zipcode is not found" do
      let(:zipcode) { "11111111" }

      it "returns a zipcode not found error" do
        expect { address.zipcode }.to raise_error(Brazil::Cep::ZipcodeNotFound)
      end
    end
  end
end
