# frozen_string_literal: true

require_relative "dashboards/version"
require_relative "dashboards/configuration"
require_relative "dashboards/dsl"
require_relative "dashboards/engine" if defined?(Rails)

# Require all the dependencies
require "importmap-rails"
require "chartkick"
require "groupdate"

module Dashboards
  class Error < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end

# Set default configuration
Dashboards.configure do |config|
  config.chart_library = :chartkick
end
