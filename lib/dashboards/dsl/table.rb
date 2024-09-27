# frozen_string_literal: true

module Dashboards
  class Table
    attr_reader :name, :data, :options

    def initialize(name, options = {})
      @name = name
      @data = options[:data]
      @options = options.except(:data)
    end

    def render
      # Implement table rendering logic
    end
  end
end
