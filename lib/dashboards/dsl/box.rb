module Dashboards
  class Box
    attr_reader :name, :elements

    def initialize(name)
      @name = name
      @elements = []
    end

    def metric(name, options = {})
      @elements << Metric.new(name, options)
    end

    def chart(name, options = {})
      @elements << Chart.new(name, options)
    end

    def table(name, options = {})
      @elements << Table.new(name, options)
    end

    def summary(data_or_options, options = {})
      @elements << Summary.new(data_or_options, options)
    end

    def custom(&block)
      @elements << CustomElement.new(block)
    end

    def change_over_period(data_or_options, options = {})
      @elements << ChangeOverPeriod.new(data_or_options, options)
    end
  end
end
