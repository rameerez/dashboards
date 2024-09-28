# frozen_string_literal: true

module Dashboards
  class Dashboard
    attr_reader :name, :boxes, :slug

    def initialize(name, options = {})
      @name = name
      @slug = options[:slug] || name.parameterize
      @boxes = []
    end

    def box(name, &block)
      @boxes << Box.new(name).tap { |b| b.instance_eval(&block) }
    end
  end
end
