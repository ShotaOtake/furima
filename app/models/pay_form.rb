class PayForm
  # ActiveModel::Modelをincludeすると、そのクラスのインスタンスはActiveRecordを継承したクラスのインスタンスと同様に form_with や render などのヘルパーメソッドの引数として扱えたり、バリデーションの機能が使えるようになる
  include ActiveModel::Model

  # 保存したい複数のテーブルのカラム名全てを属性値として扱えるようにする
  # フォームで利用する全ての属性(つまり、保存したい各テーブルのカラム名全て)についてゲッターとセッターを定義することで、このFormオブジェクトのインスタンスを生成した際にform_withの引数として利用できるようになる
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id ,:item_id


end