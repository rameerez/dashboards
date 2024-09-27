# frozen_string_literal: true

module Dashboards
  class Chart
    attr_reader :name, :type, :data, :options

    def initialize(name, options = {})
      @name = name
      @type = options.delete(:type) || :line
      @data = options.delete(:data)
      @options = options
    end

    def render(context)
      data = @data.is_a?(Proc) ? context.instance_exec(&@data) : @data
      case Dashboards.configuration.chart_library
      when :chartkick
        render_chartkick(context, data)
      else
        render_fallback(data)
      end
    end

    private

    def render_chartkick(context, data)
      if defined?(Chartkick)
        chart_method = "#{@type}_chart"
        options = @options.merge(title: @name)

        if Chartkick.respond_to?(chart_method)
          Chartkick.public_send(chart_method, data, **options)
        elsif context.respond_to?(chart_method)
          context.public_send(chart_method, data, **options)
        else
          render_fallback(data)
        end
      else
        render_fallback(data)
      end
    end

    def render_fallback(data)
      "<div class='chart'>
        <h3>#{@name}</h3>
        <p>Chart data: #{data.inspect}</p>
        <p>Note: Chartkick is not available. Please include it in your application for chart rendering.</p>
      </div>"
    end
  end
end
