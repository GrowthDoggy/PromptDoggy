Rails.application.routes.draw do
  root 'landing_page#index'
  get 'about_us', to: 'landing_page#about_us'

  # auth routes
  resources :users, only: [:create]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  resources :projects, param: :token do
    resources :prompts do
      member do
        post 'deploy'
      end
    end
    resources :environments, param: :token
  end
end
