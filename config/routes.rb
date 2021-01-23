Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root "items#index"
  resources :items
end
