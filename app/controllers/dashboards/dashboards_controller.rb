module Dashboards
  class DashboardsController < BaseController
    def index
      if Dashboards.configuration.dashboards.empty?
        render :no_dashboards
      else
        first_dashboard = Dashboards.configuration.dashboards.first
        redirect_to dashboard_path(first_dashboard.slug)
      end
    end

    def show
      @dashboard = Dashboards.configuration.find_dashboard(params[:dashboard])
      if @dashboard.nil?
        redirect_to root_path, alert: "Dashboard not found"
      end
    end
  end
end
