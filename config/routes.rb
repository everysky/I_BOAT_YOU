Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boats do
    resources :bookings, only: [ :new, :create] 
  end
  get :my_bookings, to: 'bookings#my_bookings'
  get :my_boats, to: 'boats#my_boats'
end
