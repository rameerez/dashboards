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
      render_table(data)
    end

    private

    def render_table(data)
      table_html = "<div class='table'><h3>#{@name}</h3><table>"
      # table_html += '<tr><th>Item</th><th>Count</th></tr>'

      data.each do |item, count|
        table_html += "<tr><td>#{item}</td><td>#{count}</td></tr>"
      end

      table_html += '</table></div>'
      table_html
    end
  end
end
