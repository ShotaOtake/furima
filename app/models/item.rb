class Item < ApplicationRecord

  # <<アソシエーション>>

  # モデル間のアソシエーション
  belongs_to :user
  # has_one_attachedを使用してimageカラムとのアソシエーションを記述
  has_one_attached :image

  # Active_hashとのアソシエーション
  # ActiveHashを用いてアソシエーションを設定する場合は、ActiveHashで定義されているmoduleをモデルに取り込む必要がある
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  

　# <<バリデーション>>


end
