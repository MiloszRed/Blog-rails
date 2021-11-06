Rails.application.routes.draw do
  devise_for :users
  resources :posts do 
    resources :comments
    resources :images
  end
  
  namespace :admin do
    resources :posts do 
      resources :comments
      resources :images
    end
  end

  root 'posts#index'
end
