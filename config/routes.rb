Rails.application.routes.draw do
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

  devise_for :users,
  controllers: {
    registrations: :registrations,
    sessions: :sessions
  },
  defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :posts do 
          resources :comments
          resources :images
        end
      end
      resources :posts do 
        resources :comments
        resources :images
      end
    end
  end

  root 'posts#index'
end
