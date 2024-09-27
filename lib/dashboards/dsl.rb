# frozen_string_literal: true

require_relative "dsl/chart"
require_relative "dsl/dashboard"
require_relative "dsl/element"
require_relative "dsl/metric"
require_relative "dsl/section"
require_relative "dsl/table"

module Dashboards
  module DSL
    def dashboard(name, &block)
      dashboard = Dashboard.new(name)
      dashboard.instance_eval(&block)
      Dashboards.configuration.add_dashboard(dashboard)
    end
  end

  class CustomElement
    def initialize(block)
      @block = block
    end

    def render(context)
      context.instance_eval(&@block)
    end
  end
end
