Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root "items#index"
  # itemsコントローラーにordersコントローラーをネスト
  resources :items do
    resources :orders, only:[ :index, :create ] 
  end

end
