# frozen_string_literal: true

module Dashboards
  class ChangeOverPeriod
    attr_reader :data, :options

    def initialize(data_or_options, options = {})
      if data_or_options.is_a?(Hash)
        @data = data_or_options[:data]
        @options = data_or_options.except(:data)
      else
        @data = data_or_options
        @options = options
      end
      @period = @options[:period] || 7.days
      @date_column = @options[:date_column] || :created_at
    end

    def render(context)
      data = @data.is_a?(Proc) ? context.instance_exec(&@data) : @data
      render_change(data, context)
    end

    private

    def render_change(data, context)
      now = Time.current
      current_count = data.where(@date_column => @period.ago(now)..now).count
      previous_count = data.where(@date_column => @period.ago(@period.ago(now))..@period.ago(now)).count

      if previous_count.zero?
        percentage_change = current_count.positive? ? 100 : 0
      else
        percentage_change = ((current_count - previous_count).to_f / previous_count * 100).round
      end

      sign = percentage_change.positive? ? '+' : ''
      chevron = percentage_change.positive? ? '▴' : '▾'
      color = percentage_change.positive? ? 'green' : 'red'
      period_text = case @period
                    when 7.days then 'last week'
                    when 30.days then '30d ago'
                    else "#{@period.inspect} ago"
                    end

      html = "<div class='change-over-period'>"
      html += "<span>Since #{period_text}</span>"
      html += "<span class='change-over-period-pill' style='color: #{color};'>"
      html += "#{sign}#{percentage_change}% #{chevron}"
      html += "</span>"
      html += "</div>"

      html
    end
  end
end
