Rails.application.routes.draw do

  root to: 'statics#home'
  
  get '/team', to: 'statics#team'
  get '/contact', to: 'statics#contact'

  resources :gossips
  resources :users
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
