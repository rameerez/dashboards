Dashboards::Engine.routes.draw do
  root to: "dashboards#index"
  get "/:dashboard", to: "dashboards#show", as: :dashboard
end
