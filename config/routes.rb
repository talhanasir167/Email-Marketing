Rails.application.routes.draw do
  resources :businesses
  root to: 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/create_emails', to: 'home#create_emails', as: 'create_emails'
end
