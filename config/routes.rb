Rails.application.routes.draw do
  post 'login', to: 'sessions#login'

  # handle incoming mails
  mount_griddler

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # handle requests from ember frontend app
  mount_ember_app :frontend, to: '/'
end
