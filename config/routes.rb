Rails.application.routes.draw do
  root "orders#index"
  resources :orders, only: [ :index, :update ], param: :id
end
