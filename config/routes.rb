Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
   
 namespace :api do
      resources :users
      get 'users/:id/followers', to: 'users#followers'
      get 'users/:id/following', to: 'users#following'
    end
  

  

   post 'login', to: 'authorization#create'

   namespace :api do
    resources :posts do
      collection do
        get :top_posts
        get :recommended_posts
        get :drafts
        get 'saved_posts', to: 'posts#saved_posts'
      end
      member do
        post :save_for_later
        get :revisions
      end
    end
  end

  namespace :api do
  resources :users do
    resources :lists, only: [:index, :create, :show] do
    member do
      post :add_post
      get :share
    end
  end
end
end


namespace :api do
  resources :lists, only: [:show] do
    member do
      post :share
    end
  end
end



namespace :api do
  post 'payments/create_order', to: 'payments#create_order'
  post 'payments/webhook', to: 'payments#webhook'
end



    namespace :api do
      resources :posts
    end
  

    namespace :api do
      resources :follows 
    end
 
    namespace :api do
      resources :comments
    end

    namespace :api do
      resources :likes
    end
    
  
    namespace :api do
      resources :comments do
        get 'for_post/:post_id', action: :comments_for_post, on: :collection
      end
    end
  

     namespace :api do
     post '/login', to: 'sessions#create'
     delete '/logout', to: 'sessions#destroy'
   end

 
end
