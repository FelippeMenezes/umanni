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
end
