Rails.application.routes.draw do
  resources :invoices
  resources :items
  resources :clients
  resources :companies
  devise_for :users
  # get '/invoices/:id', to: 'invoices#pending'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # root 'users#sign_in'
    root "items#index"
    get 'items/:id' => 'items#bending'

end
