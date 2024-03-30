Rails.application.routes.draw do
  root to: 'businesses#index'

  resources :businesses do
    resources :leads, shallow: true, except: %i[index]
  end
  resources :users, except: %i[new create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
