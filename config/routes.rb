Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :update]
  resources :shelters do
    get :drafts, on: :collection
  end
  resources :needs do
    get :drafts, on: :collection
  end
  resources :drafts, only: [:show, :destroy] do
    post :accept, on: :member
  end
  resources :amazon_products

  root to: "shelters#index"
  namespace :api do
    namespace :v1 do

      post "/google-sheet-update" => "hooks#sheet_update"

      get "/needs" => 'needs#index'
      get "/shelters" => 'shelters#index'
      get "/products" => 'amazon_products#index'
    end
  end
end
