Rails.application.routes.draw do
  root 'home#index'

  # Maps
  post '/maps', to: 'maps#create'
  get  '/maps/:id/best_route', to: 'maps#best_route'

end
