Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in' , as: 'users_guest_sign_in'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get '/auth/failure', to: 'sessions#failure', as:'failure_session'

  get '/', to:'reservations#index', as:'index_reservation'

  get 'reservations/show/:date', to:'reservations#show', as:'show_reservation'

  get 'reservations/new/:date/:time_slot', to:'reservations#new', as:'new_reservation'
  post 'reservations/new/:date/:time_slot', to:'reservations#create', as:'create_reservation'

  get 'reservations/confirm', to:'reservations#confirm', as:'confirm_reservation'  
  delete 'reservations/confirm/destroy/:id', to:'reservations#destroy', as:'destroy_reservation'
  
  get 'users/show', to:'users#show', as:'show_user'
  patch 'users/show', to:'users#update', as:'update_user'

  # Defines the root path route ("/")
  # root "articles#index"
end
