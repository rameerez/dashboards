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
      Dashboard.new(name).tap { |d| d.instance_eval(&block) }
    end
  end
end
