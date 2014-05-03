Rails.application.routes.draw do
  root 'home#index'

  # Maps
  post '/maps', :to => 'maps#create'
end
