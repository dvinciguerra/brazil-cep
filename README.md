# Brazil::Cep

[![Gem Version](https://badge.fury.io/rb/brazil-cep.svg)](https://badge.fury.io/rb/brazil-cep)
[![Ruby](https://github.com/dvinciguerra/brazil-cep/actions/workflows/main.yml/badge.svg)](https://github.com/dvinciguerra/brazil-cep/actions/workflows/main.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/ebe40dff21c15748fd1c/maintainability)](https://codeclimate.com/github/dvinciguerra/brazil-cep/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ebe40dff21c15748fd1c/test_coverage)](https://codeclimate.com/github/dvinciguerra/brazil-cep/test_coverage)

This gem provides a simple way to validate and format Brazilian postal codes (CEP).

## Installation

`$ gem install brazil-cep`

Or add this line to your application's Gemfile:

```ruby
gem 'brazil-cep'
```

## Usage

### Fetching address by CEP using default provider

```ruby
address = Brazil::Cep.fetch('01311-200')
address.street # => "Avenida Paulista"
address.neighborhood # => "Bela Vista"
```

### Fetching address by CEP using custom provider

```ruby
address = Brazil::Cep.fetch('01311-200', provider: :postmon)
address.street # => "Avenida Paulista"
address.neighborhood # => "Bela Vista"
```

### Creating a custom provider adapter

```ruby
module Brazil
  module Cep
    module Adapters
      class MyProvider < Base
        provider base_url: 'https://api.myprovider.com/address/{{cep}}'

        private

        def transformation!
          address_params = {
            street: response[:street],
            neighborhood: response[:neighborhood],
            ...
          }
          
          Brazil::Cep::Address.new(**address_params)
      end
    end
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dvinciguerra/brazil-cep. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dvinciguerra/brazil-cep/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Brazil::Cep project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dvinciguerra/brazil-cep/blob/master/CODE_OF_CONDUCT.md).

## License

Created by Daniel Vinciguerra and available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

