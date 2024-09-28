# frozen_string_literal: true

module Dashboards
  class Chart
    attr_reader :name, :type, :data, :options

    DEFAULT_HEIGHT = '120px'
    DEFAULT_COLOR = '#FFFFFF'  # White

    def initialize(name_or_options, options = {})
      if name_or_options.is_a?(Hash)
        @name = nil
        options = name_or_options
      else
        @name = name_or_options
      end
      @type = options.delete(:type) || :line
      @data = options.delete(:data)
      @options = options
      @options[:height] ||= DEFAULT_HEIGHT
      @options[:color] ||= DEFAULT_COLOR
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
        options = @options.dup

        # Only add title if @name is present
        options[:title] = @name if @name

        # Apply color to different chart types
        case @type
        when :pie, :donut
          options[:colors] ||= [@options[:color]]
        when :column, :bar
          options[:colors] ||= [@options[:color]]
        else
          options[:dataset] ||= {
            borderColor: @options[:color],
            backgroundColor: @options[:color],
            pointBackgroundColor: @options[:color],
            pointBorderColor: @options[:color],
            pointHoverBackgroundColor: @options[:color],
            pointHoverBorderColor: @options[:color],
            hoverBackgroundColor: @options[:color],
            hoverBorderColor: @options[:color]
          }
        end

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
      html = "<div class='chart' style='height: #{@options[:height]}; color: #{@options[:color]};'>"
      html += "<h3>#{@name}</h3>" if @name
      html += "<p>Chart data: #{data.inspect}</p>"
      html += "<p>Note: Chartkick is not available. Please include it in your application for chart rendering.</p>"
      html += "</div>"
      html
    end
  end
end
