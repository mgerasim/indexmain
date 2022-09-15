Rails.application.routes.draw do
  resources :regions
  resources :volumes
  resources :tasks
  root :to => "tasks#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
