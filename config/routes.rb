Rails.application.routes.draw do
  resource :users
  resource :quarks

  root 'quarks#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
