# frozen_string_literal: true

module Dashboards
  class Loader
    def self.load
      config_file = Rails.root.join("config", "dashboards.rb")
      return unless File.exist?(config_file)

      Dashboards.configuration.dashboard = Class.new do
        extend Dashboards::DSL
        instance_eval(File.read(config_file))
      end.dashboard
    end
  end
end
