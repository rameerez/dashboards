# frozen_string_literal: true

module Dashboards
  class Table
    attr_reader :name, :data, :options

    def initialize(name_or_options, options = {})
      if name_or_options.is_a?(Hash)
        @name = nil
        options = name_or_options
      else
        @name = name_or_options
      end
      @data = options[:data] || options[:value]
      @options = options.except(:data, :value)
    end

    def render(context)
      data = @data.is_a?(Proc) ? context.instance_exec(&@data) : @data
      render_table(data)
    end

    private

    def render_table(data)
      table_html = "<div class='table'>"
      table_html += "<h3>#{@name}</h3>" if @name
      table_html += "<table>"

      if data.is_a?(Hash)
        table_html += render_hash_data(data)
      elsif data.respond_to?(:each)
        table_html += render_array_data(data)
      else
        table_html += "<tr><td>No data available</td></tr>"
      end

      table_html += '</table></div>'
      table_html
    end

    def render_hash_data(data)
      html = ""
      # html += "<tr><th>Key</th><th>Value</th></tr>"
      data.each do |key, value|
        html += "<tr><td>#{key}</td><td>#{value}</td></tr>"
      end
      html
    end

    def render_array_data(data)
      html = ""
      if data.first.is_a?(Hash)
        keys = data.first.keys
        html += "<tr>#{keys.map { |key| "<th>#{key}</th>" }.join}</tr>"
        data.each do |item|
          html += "<tr>#{keys.map { |key| "<td>#{item[key]}</td>" }.join}</tr>"
        end
      else
        data.each do |item|
          html += "<tr><td>#{item}</td></tr>"
        end
      end
      html
    end
  end
end
