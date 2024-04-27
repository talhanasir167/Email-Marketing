require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :businesses do
    resources :leads, shallow: true, except: %i[index]
  end

  resources :contacts, only: %i[edit update]

  get '/followups/:id', to: 'leads#followup', as: 'followup'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
