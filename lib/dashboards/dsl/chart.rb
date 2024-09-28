# frozen_string_literal: true

module Dashboards
  class Chart
    attr_reader :name, :type, :data, :options

    VALID_TYPES = [:line, :pie, :column, :bar, :area, :scatter]

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
      @options[:height] ||= options[:height] || DEFAULT_HEIGHT
      @options[:color] ||= DEFAULT_COLOR
    end

    def render(context)
      data = @data.is_a?(Proc) ? context.instance_exec(&@data) : @data
      chartkick_method = chartkick_method(@type)

      options = @options.dup
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

      # Apply height
      options[:height] = @options[:height]

      raise ArgumentError, "Invalid chart type: #{@type}" unless VALID_TYPES.include?(@type)

      if context.respond_to?(chartkick_method)
        context.public_send(chartkick_method, data, **options)
      else
        render_fallback(data)
      end
    end

    private

    def chartkick_method(type)
      case type
      when :line then :line_chart
      when :pie then :pie_chart
      when :column then :column_chart
      when :bar then :bar_chart
      when :area then :area_chart
      when :scatter then :scatter_chart
      else
        raise ArgumentError, "Unsupported chart type: #{type}"
      end
    end

    def render_fallback(data)
      "<div class='chart' style='height: #{@options[:height]}; color: #{@options[:color]};'>
        <h3>#{@name}</h3>
        <p>Chart data: #{data.inspect}</p>
        <p>Note: Chartkick is not available. Please include it in your application for chart rendering.</p>
      </div>"
    end
  end
end
