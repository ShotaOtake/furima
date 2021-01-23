Rails.application.routes.draw do
  # ルートパスの設定
  root "items#index"
  resources :items
end
