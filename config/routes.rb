Rails.application.routes.draw do
  root "orders#index"
  resources :orders, only: %i[index new create show] do
    member do
      patch :advance
      get :document
    end
  end
end
