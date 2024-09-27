# frozen_string_literal: true

module Dashboards
  class Dashboard
    attr_reader :name, :sections, :slug

    def initialize(name, options = {})
      @name = name
      @slug = options[:slug] || name.parameterize
      @sections = []
    end

    def section(name, &block)
      @sections << Section.new(name).tap { |s| s.instance_eval(&block) }
    end
  end
end
