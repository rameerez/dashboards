# frozen_string_literal: true

module Dashboards
  class Metric
    attr_reader :name, :value, :options

    def initialize(name, options = {})
      @name = name
      @value = options[:value]
      @options = options.except(:value)
    end

    def render
      "<div class='metric'>
        <h3>#{@name}</h3>
        <p class='value'>#{@value}</p>
      </div>"
    end
  end
end
