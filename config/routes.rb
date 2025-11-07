Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    get "dashboard", to: "dashboard#show", as: :dashboard
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get :import_form, as: :import_form
        post :import, as: :import
      end
      member do
        delete :delete
      end
    end
  end
  
  get "/example_users.csv", to: "admin/users#download_example", as: :download_example_users
  resources :profiles, only: [:show, :edit, :update, :destroy]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
