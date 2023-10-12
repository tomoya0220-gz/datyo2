Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/', to:'reservations#index', as:'index_reservation'

  get 'reservations/show/:date', to:'reservations#show', as:'show_reservation'

  get 'reservations/new/:date', to:'reservations#new', as:'new_reservation'

  get '/auth/:provider/callback', to: 'sessions#create', as:'create_session'
  # Defines the root path route ("/")
  # root "articles#index"
end
