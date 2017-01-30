Rails.application.routes.draw do
  post 'signin', to: 'sessions#signin'

  # handle incoming mails
  mount_griddler

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
