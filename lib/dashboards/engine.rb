# frozen_string_literal: true

require_relative "loader"

module Dashboards
  class Engine < ::Rails::Engine
    isolate_namespace Dashboards

    initializer "dashboards.load_configuration" do
      config.after_initialize do
        Dashboards::Loader.load
      end
    end

  end
end
