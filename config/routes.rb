Rails.application.routes.draw do
  get 'meal_assignment/index'

  get 'user/index'
  resources :user do
    member do
      get 'preference', to: 'preference#new'
      get 'preference/new'
      get 'preference/edit'
      put 'preference/update'
    end
  end

  devise_for :users
  root 'home#index'
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
