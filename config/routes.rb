Rails.application.routes.draw do
  get 'user/index'
  resources :user do
    resource :preference
  end

  devise_for :users
  root 'home#index'
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
