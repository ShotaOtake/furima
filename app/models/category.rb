# モデル内（クラス内）でActiveHashを用いる際に必要となるクラス
# ActiveHash::Baseを継承することで、ActiveRecordと同じようなメソッドを使用できるようになる
class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: 'レディース' },
    { id: 2, name: 'メンズ' },
    { id: 3, name: 'ベビー・キッズ' },
    { id: 4, name: 'インテリア・住まい・小物' },
    { id: 5, name: '本・音楽・ゲーム' },
    { id: 6, name: 'おもちゃ・ホビー・グッズ' },
    { id: 7, name: '家電・スマホ・カメラ' },
    { id: 8, name: 'スポーツ・レジャー' },
    { id: 9, name: 'ハンドメイド' },
    { id: 10, name: 'その他' }
  ]

  # ActiveHashを用いてhas_manyを設定するには、include ActiveHash::Associationsと記述してmoduleを取り込む
  include ActiveHash::Associations
    has_many :items
end
