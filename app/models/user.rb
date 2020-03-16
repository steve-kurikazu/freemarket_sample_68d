class User < ApplicationRecord
  has_one  :profile
  has_many :items
  has_many :sendings, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :items, through: :likes
  has_many :orders
  has_many :sns_credentials

  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end
  
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
       
  with_options presence: true do
    validates :nickname, uniqueness: true, length: { maximum: 8 }
    validates :email, uniqueness: true 
    validates :birth_year
    validates :birth_month
    validates :birth_day
  end

  with_options format: {with: /\A[ぁ-んァ-ン一-龥]/} do
    validates :firstname
    validates :lastname
  end
  with_options format: {with: /\A[ぁ-んー－]+\z/} do
    validates :firstname_kana
    validates :lastname_kana
  end
end