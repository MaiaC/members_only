Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/index'
  root 'static_pages#home'
  get 'about', to: "static_pages#about"
  get 'contact', to: "static_pages#contact"
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"

  resources :posts, only: [:new, :create, :index]
  
end
