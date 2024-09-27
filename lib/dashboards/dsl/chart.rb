# frozen_string_literal: true

module Dashboards
  class Chart
    attr_reader :name, :type, :data, :options

    def initialize(name, options = {})
      @name = name
      @type = options[:type] || :line
      @data = options[:data]
      @options = options.except(:type, :data)
    end

    def render
      case Dashboards.configuration.chart_library
      when :chartkick
        render_chartkick
      else
        raise Error, "Unsupported chart library: #{Dashboards.configuration.chart_library}"
      end
    end

    private

    def render_chartkick
      chart_method = "#{@type}_chart"
      if Chartkick.respond_to?(chart_method)
        Chartkick.public_send(chart_method, @data, @options.merge(title: @name))
      else
        raise Error, "Unsupported chart type: #{@type}"
      end
    end
  end
end
