# frozen_string_literal: true

module Dashboards
  class Loader
    def self.load
      config_file = Rails.root.join("config", "dashboards.rb")
      unless File.exist?(config_file)
        Rails.logger.warn "Dashboards configuration file not found at #{config_file}"
        return
      end

      begin
        Class.new do
          extend Dashboards::DSL
          instance_eval(File.read(config_file))
        end
      rescue StandardError => e
        Rails.logger.error "Error loading Dashboards configuration: #{e.message}"
        raise Dashboards::ConfigurationError, "Failed to load Dashboards configuration: #{e.message}"
      end
    end
  end
end
