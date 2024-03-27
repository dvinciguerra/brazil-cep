# frozen_string_literal: true

module Brazil
  module Cep
    # Address class
    class Address
      attr_reader :zipcode, :state, :city, :neighborhood, :street, :complement, :meta

      def initialize(**arguments)
        @zipcode = arguments[:zipcode]
        @state = arguments[:state]
        @city = arguments[:city]
        @neighborhood = arguments[:neighborhood]
        @street = arguments[:street]
        @complement = arguments[:complement]
        @meta = arguments[:meta]
      end

      def provider
        meta[:provider]
      end
    end
  end
end
