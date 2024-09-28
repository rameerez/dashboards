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

    initializer "dashboards.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << root.join("app/assets/javascripts")
    end

    initializer "dashboards.assets" do |app|
      app.config.assets.precompile += %w[dashboards_manifest.js dashboards/application.js dashboards/application.css]
    end

    initializer "dashboards.append_assets_path" do |app|
      app.config.assets.paths << root.join("app/assets/javascripts")
      app.config.assets.paths << Chartkick::Engine.root.join("vendor/assets/javascripts")
    end
  end
end
