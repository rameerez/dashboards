# frozen_string_literal: true

module Dashboards
  class Section
    attr_reader :name, :elements

    def initialize(name)
      @name = name
      @elements = []
    end

    def show(type, name, **options)
      @elements << Element.new(type, name, options)
    end

    def metric(name, **options)
      show(:metric, name, **options)
    end

    def chart(name, **options)
      show(:chart, name, **options)
    end

    def table(name, **options)
      show(:table, name, **options)
    end
  end
end
