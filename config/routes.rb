Rails.application.routes.draw do
  resources :users, controller: "users", only: [:create] do
    resource :password, only: %i[edit update]
  end

  namespace :webhooks, defaults: { format: :json } do
    post "/activation" => "activation#webhook"
    post "/signup" => "signup#webhook"
  end

  resource :session, controller: "sessions", only: [:create]
  resources :passwords, only: %i[create new edit update]
  resources :workspaces, only: %i[index new create edit update destroy] do
    scope module: :workspaces do
      resources :workspace_members, only: %i[index new create destroy]
      resources :projects, only: %i[index new create edit update destroy] do
        scope module: :projects do
          resources :surveys, only: %i[new edit update] do
            scope module: :surveys do
              resources :results, only: %i[new create edit update]
              resource :shares, only: [:show]
              resource :analytics, only: [:show]
              resource :detailed_analytics, only: [:show]
            end
          end
        end
      end
    end
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  get "/sign_out" => "sessions#destroy", as: "sign_out"

  get "/:id" => "shortener/shortened_urls#show"

  constraints Clearance::Constraints::SignedOut.new do
    root to: "sessions#new"
  end

  constraints Clearance::Constraints::SignedIn.new do
    root to: "workspaces#index", as: :signed_in_root
  end

  mount ActionCable.server => "/cable"
end
