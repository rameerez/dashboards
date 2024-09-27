module Dashboards
  class DashboardsController < BaseController
    def index
      @dashboards = Dashboards.configuration.dashboards
    end

    def show
      @dashboard = Dashboards.configuration.find_dashboard(params[:dashboard])
      if @dashboard.nil?
        redirect_to root_path, alert: "Dashboard not found"
      end
    end
  end
end
