require "spec_helper"

RSpec.describe Brazil::Cep do
  let(:version_number) { /^\d{1,2}.\d{1,3}.\d{1,3}$/ }

  it "has a version number" do
    expect(Brazil::Cep::VERSION).to match version_number
  end
end
