Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'prompts/index'
      get 'prompts/show'
    end
  end
  root 'landing_page#index'
  get 'about_us', to: 'landing_page#about_us'

  # auth routes
  resources :users, only: [:create]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  # openapi routes
  namespace :api do
    namespace :v1 do
      resources :projects, param: :token, only: [] do
        resources :environments, param: :token, only: [] do
          resources :prompts, only: [:index, :show], param: :name
          end
        end
    end
  end

  # console routes
  resources :projects, param: :token do
    resources :prompts do
      member do
        post 'deploy'
      end
    end
    resources :environments, param: :token
  end

  get 'settings', to: 'settings#show'
end
