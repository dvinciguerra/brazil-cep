# frozen_string_literal: true

# enable code coverage report
require "simplecov"
SimpleCov.start if ENV.fetch("COVERAGE", "false") == "true"

require "brazil-cep"
Dir["../lib/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.filter_run_when_matching :focus unless ENV["CI"]

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
