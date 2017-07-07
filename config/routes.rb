Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations"}
  root 'friendships#index'

  resources :users, :only => [:index]

  resources :friendships
end
