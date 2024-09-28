# frozen_string_literal: true

module Dashboards
  class Metric
    attr_reader :name, :value, :options

    def initialize(name_or_options, options = {})
      if name_or_options.is_a?(Hash)
        @name = nil
        options = name_or_options
      else
        @name = name_or_options
      end
      @value = options[:value]
      @options = options.except(:value)
      @format_big_numbers = options[:format_big_numbers] || false
    end

    def render(context)
      value_content = @value.is_a?(Proc) ? context.instance_exec(&@value) : @value
      formatted_value = format_number(value_content)
      if @name
        "<div class='metric'>
          <h3>#{@name}</h3>
          <div class='metric-value'>#{formatted_value}</div>
        </div>"
      else
        "<div class='metric'>
          <div class='metric-value'>#{formatted_value}</div>
        </div>"
      end
    end

    private

    def format_number(number)
      return number unless number.is_a?(Numeric)

      if @format_big_numbers
        if number >= 1_000_000
          "#{(number / 1_000_000.0).round(1)}M"
        elsif number >= 1_000
          "#{(number / 1_000.0).round(1)}K"
        else
          number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        end
      else
        number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
      end
    end
  end
end
