Rails.application.routes.draw do

  root "products#index"
  resources :products do
    collection do
      get :soft_delete_index
    end
    member do
      get :recover
    end
  end

  resources :orders do
    member do
      post :add_item
      delete :remove_item
      post :place_order
      get :recover
    end
    collection do
      get :soft_delete_index
    end
    resources :order_items, only: [:create, :edit, :update, :destroy]
  end
  devise_for :users, sign_out_via: [:get]


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
