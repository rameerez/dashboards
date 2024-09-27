module Dashboards
  class Configuration
    attr_reader :dashboards
    attr_accessor :chart_library

    def initialize
      @dashboards = []
      @chart_library = :chartkick # Default to chartkick
    end

    def add_dashboard(dashboard)
      @dashboards << dashboard
    end

    def find_dashboard(slug)
      @dashboards.find { |d| d.slug == slug }
    end
  end
end
