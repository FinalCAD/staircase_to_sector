require "bundler/setup"

require "file_model"
require "staircase_to_sector"

begin
  require 'pry'
rescue LoadError
end

begin
  require 'coveralls'
  Coveralls.wear!
rescue LoadError
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
