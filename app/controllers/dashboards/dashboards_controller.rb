module Dashboards
  class DashboardsController < BaseController
    def index
    end

    def show
      @dashboard = Dashboards::Loader.load
    end
  end
end
