Rails.application.routes.draw do
  get 'users/new'
  post 'users/create'

  get 'counter/index'
  post 'counter', to: 'counter#create'

  root 'counter#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
