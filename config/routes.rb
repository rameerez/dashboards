Dashboards::Engine.routes.draw do
  root 'dashboards#index'
  get '/:dashboard', to: 'dashboards#show', as: :dashboard
end
