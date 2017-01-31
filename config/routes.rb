Rails.application.routes.draw do
  # handle requests from ember frontend app
  mount_ember_app :frontend, to: "/"

  post 'signin', to: 'sessions#signin'

  # handle incoming mails
  mount_griddler

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
