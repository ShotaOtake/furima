class PayForm
  # ActiveModel::Modelをincludeすると、そのクラスのインスタンスはActiveRecordを継承したクラスのインスタンスと同様に form_with や render などのヘルパーメソッドの引数として扱えたり、バリデーションの機能が使えるようになる
  include ActiveModel::Model

  # 保存したい複数のテーブルのカラム名全てを属性値として扱えるようにする
  # フォームで利用する全ての属性(つまり、保存したい各テーブルのカラム名全て)についてゲッターとセッターを定義することで、このFormオブジェクトのインスタンスを生成した際にform_withの引数として利用できるようになる
  # tokenの値追加
  attr_accessor  :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id ,:item_id , :token

  # <<バリデーション>>
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/}
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11 }
    validates :user_id
    validates :item_id 
  end

  def save
    order = Order.create(
      #保存した情報を変数orderにいれる
      item_id: item_id,
      user_id: user_id
    )
    Address.create(
      order_id: order.id,
      #保存された情報を持つ変数orderから、idだけを取り出し、order_idとして保存を行う
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number
    )
  end
end