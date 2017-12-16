Rails.application.routes.draw do
  

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  #root 'welcome#home'
  root 'lists#index'

  resources :lists do
    resources :chores
    resources :chores do
      get 'complete', :on => :member
    end
    resources :invites
  end
  resources :users

  get '/lists/:id/join', to: 'lists#join', as: :join_list
  get '/lists/:id/remove_user', to: 'lists#remove_user', as: :remove_from_list
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
