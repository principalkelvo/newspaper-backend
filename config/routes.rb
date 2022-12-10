Rails.application.routes.draw do
  resources :categories
  # devise_for :users, defaults: { format: :json } 

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }, defaults: { format: :json } 

             #!signout not working
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
