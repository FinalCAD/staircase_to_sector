require "staircase_to_sector/version"
require "active_support/dependencies/autoload"

require_relative 'staircase_to_sector/configuration'

module StaircaseToSector
  extend ActiveSupport::Autoload

  autoload :Lib
  autoload :Metadata
  autoload :Models
  autoload :Feeder
  autoload :Processors

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
