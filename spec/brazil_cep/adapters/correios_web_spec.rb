# frozen_string_literal: true

require "spec_helper"

RSpec.describe Brazil::Cep::Adapters::CorreiosWeb do
  describe ".provider" do
    subject(:address) { described_class.new.fetch(zipcode) }

    let(:zipcode) { "01311200" }

    it "returns a valid location based on zipcode" do
      expect(address.zipcode).to eq("01311200")
    end

    context "when the zipcode is not found" do
      let(:zipcode) { "11111111" }

      it "returns a zipcode not found error" do
        expect { address.zipcode }.to raise_error(Brazil::Cep::ZipcodeNotFound)
      end
    end
  end
end
