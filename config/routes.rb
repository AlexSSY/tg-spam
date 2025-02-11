Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#home"
  get "/:message_id", to: "pages#home", as: :home_with_message, constraints: { message_id: /\d+/ }

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  resource :session
  resource :registration

  resources :accounts do
    collection do
      get "authenticate", to: "accounts#authenticate", as: :authenticate
      post "send/code", to: "accounts#send_code", as: :send_code
    end
  end

  resources :messages do
    get "select", to: "messages#select", as: :select, on: :collection
    post "select", to: "messages#select_create", as: :select_create, on: :collection
  end
  resources :spams do
    get "start", to: "spams#start", as: :start, on: :member
    get "status", to: "spams#status", as: :status, on: :member
  end
end
