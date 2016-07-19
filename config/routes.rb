Rails.application.routes.draw do
  get 'users/new'
  post 'users/create'

  get 'quarks/index'
  post 'quarks' => 'quarks#create'

  root 'quarks#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
