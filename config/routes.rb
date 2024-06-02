require 'sidekiq/web'

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'home#index'

  devise_for :users

  resources :businesses
  resources :compaigns, except: %i[index]

  get '/followups/:id', to: 'compaigns#followup', as: 'followup'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
