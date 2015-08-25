PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    resources :comments do
      member do
        post :vote
      end
    end
      

    member do 
      post :vote
    end
  end 

  resources :password_reset, except: [:destroy]

  resources :categories

  get 'register', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'confirm_user', to: 'password_reset#confirm_password'
  post 'confirm_user', to: 'password_reset#auth_confirm_password'

end
