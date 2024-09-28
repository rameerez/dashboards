# frozen_string_literal: true

module Dashboards
  class Summary
    attr_reader :data, :options

    DEFAULT_PERIODS = [
      { name: '24h', duration: 24.hours },
      { name: '7d', duration: 7.days },
      { name: '30d', duration: 30.days }
    ]

    def initialize(data_or_options, options = {})
      if data_or_options.is_a?(Hash)
        @data = data_or_options[:data]
        @options = data_or_options.except(:data)
      else
        @data = data_or_options
        @options = options
      end
      @periods = @options[:periods] || DEFAULT_PERIODS
    end

    def render(context)
      data = @data.is_a?(Proc) ? context.instance_exec(&@data) : @data
      render_summary(data, context)
    end

    private

    def render_summary(data, context)
      summary_data = calculate_summary(data)

      html = "<div class='summary'><span>"

      html += @periods.map.with_index do |period, index|
        count = context.number_with_delimiter(summary_data[index], delimiter: ',')
        "<b>last #{period[:name]}:</b> #{count}"
      end.join(' · ')

      html += "</span></div>"

      html
    end

    def calculate_summary(data)
      now = Time.now
      @periods.map do |period|
        data.where(created_at: period[:duration].ago..now).count
      end
    end
  end
end
