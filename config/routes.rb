Rails.application.routes.draw do
  root to: 'leads#new'

  resources :leads
  resources :businesses
  resources :users, except: %i[new create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
