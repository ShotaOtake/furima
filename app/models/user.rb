class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # モデル間のアソシエーション
  has_many :items

          # <<バリデーション>>
  with_options presence: true do
    # with_options:1つの条件を複数のバリデーションで共用できるときに使用する
    # 今回だとpresence: true　を全てに付与させます。
    # presence:指定された属性が「空でない」ことを確認
  
    validates :nickname
    validates :birth_date
  
    # パスワードの英数字混在を否定
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX
  
    # 全角のひらがなor漢字以外を使用していないか検証
    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/} do
    validates :first_name
    validates :last_name
    end
  
    # 全角のカタカナ以外を使用していないか検証
    with_options format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/} do
    validates :first_name_kana
    validates :last_name_kana
    end 

  end
end
