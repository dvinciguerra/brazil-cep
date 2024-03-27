# frozen_string_literal: true

# enable code coverage report
if ENV.fetch("COVERAGE", "false") == "true"
  require "simplecov"

  if ENV["CI"]
    require "simplecov-lcov"

    SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
    SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
  end

  SimpleCov.start
end

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
