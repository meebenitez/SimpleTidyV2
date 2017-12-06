Rails.application.routes.draw do
  

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'welcome#home'

  resources :lists do
    resources :chores
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
