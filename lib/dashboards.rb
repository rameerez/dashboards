# frozen_string_literal: true

require_relative "dashboards/version"
require_relative "dashboards/dsl"
require_relative "dashboards/engine" if defined?(Rails)

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
  end
end
