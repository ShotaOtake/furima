class Item < ApplicationRecord

  # モデル間のアソシエーション
  belongs_to :user
  # has_one_attachedを使用してimageカラムとのアソシエーションを記述
  has_one_attached :image

end
