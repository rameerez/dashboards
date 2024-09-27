# frozen_string_literal: true

module Dashboards
  class Element
    attr_reader :type, :name, :options

    def initialize(type, name, options)
      @type = type
      @name = name
      @options = options
    end

    def render
      case @type
      when :metric
        Metric.new(@name, @options).render
      when :chart
        Chart.new(@name, @options).render
      when :table
        Table.new(@name, @options).render
      else
        raise Error, "Unsupported element type: #{@type}"
      end
    end
  end
end
