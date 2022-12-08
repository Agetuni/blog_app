Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users
  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
  namespace :api do
    namespace :v1 do
      resources :users, only:  [:index, :show] do
        resources :posts, only:  [:index] do
          resources :comments, only:  [:index, :create]
        end
      end
    end
  end
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[create]
    end
  end
end
