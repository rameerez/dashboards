module Dashboards
  class Configuration
    attr_reader :dashboards
    attr_accessor :chart_library, :cache_duration #, :per_page

    def initialize
      @dashboards = []
      @chart_library = :chartkick # Default to chartkick
      @cache_duration = 5.minutes
      # @per_page = 20
    end

    def add_dashboard(dashboard)
      @dashboards << dashboard
    end

    def find_dashboard(slug)
      @dashboards.find { |d| d.slug == slug }
    end
  end
end
