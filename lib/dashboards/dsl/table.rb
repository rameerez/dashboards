# frozen_string_literal: true

module Dashboards
  class Table
    attr_reader :name, :data, :options

    def initialize(name, options = {})
      @name = name
      @data = options[:data]
      @options = options.except(:data)
    end

    def render(context)
      data = @data.is_a?(Proc) ? context.instance_exec(&@data) : @data
      # Implement table rendering logic here
      "<div class='table'>
        <h3>#{@name}</h3>
        <p>Table data: #{data.inspect}</p>
      </div>"
    end
  end
end
